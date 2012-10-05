require 'nuggets/range/quantile'
require 'erb'

module Jekyll

  class Tagger < Generator

    safe true

    attr_accessor :site

    @types = [:page, :feed]

    class << self; attr_accessor :types, :site; end

    def generate(site)
      self.class.site = self.site = site

      generate_tag_pages
      add_tag_cloud
    end

    private

    # Generates a page per tag and adds them to all the pages of +site+.
    # A <tt>tag_page_layout</tt> have to be defined in your <tt>_config.yml</tt>
    # to use this.
    def generate_tag_pages
      site.tags.each { |tag, posts| new_tag(tag, posts) }
    end

    def new_tag(tag, posts)
      self.class.types.each { |type|
        if layout = site.config["tag_#{type}_layout"]
          data = { 'layout' => layout, 'posts' => posts.sort.reverse! }

          name = yield data if block_given?

          site.pages << TagPage.new(
            site, site.source, site.config["tag_#{type}_dir"],
            "#{name || tag}#{site.layouts[data['layout']].ext}", data
          )
        end
      }
    end

    def add_tag_cloud(num = 5, name = 'tag_data')
      s, t = site, { name => calculate_tag_cloud(num) }
      s.respond_to?(:add_payload) ? s.add_payload(t) : s.config.update(t)
    end

    # Calculates the css class of every tag for a tag cloud. The possible
    # classes are: set-1..set-5.
    #
    # [[<TAG>, <CLASS>], ...]
    def calculate_tag_cloud(num = 5)
      range = 0

      tags = site.tags.map { |tag, posts|
        [tag.to_s, range < (size = posts.size) ? range = size : size]
      }

      range = 1..range

      tags.sort!.map! { |tag, size| [tag, range.quantile(size, num)] }
    end

  end

  class TagPage < Page

    def initialize(site, base, dir, name, data = {})
      self.content = data.delete('content') || ''
      self.data    = data

      super(site, base, dir[-1, 1] == '/' ? dir : '/' + dir, name)

      data['tag'] ||= basename
    end

    def read_yaml(*)
      # Do nothing
    end

  end

  module Filters

    def tag_cloud(site)
      site['tag_data'].map { |tag, set|
        tag_link(tag, tag_url(tag), :class => "set-#{set}")
      }.join(' ')
    end

    def tag_link(tag, url = tag_url(tag), html_opts = nil)
      html_opts &&= ' ' << html_opts.map { |k, v| %Q{#{k}="#{v}"} }.join(' ')
      %Q{<a href="#{url}"#{html_opts}>#{tag}</a>}
    end

    def tag_url(tag, type = :page, site = Tagger.site)
      url = File.join('', site.config["tag_#{type}_dir"], ERB::Util.u(tag))
      site.permalink_style == :pretty ? url : url << '.html'
    end

    def tags(obj)
      tags = obj['tags'].dup
      tags.map! { |t| t.first } if tags.first.is_a?(Array)
      tags.map! { |t| tag_link(t, tag_url(t)) if t.is_a?(String) }.compact!
      tags.join(', ')
    end

  end

end
