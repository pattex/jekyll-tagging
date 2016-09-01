require 'nuggets/range/quantile'
require 'nuggets/i18n'
require 'erb'

module Jekyll

  module Helpers

    # call-seq:
    #   jekyll_tagging_slug(str) => new_str
    #
    # Substitutes any diacritics in _str_ with their ASCII equivalents,
    # whitespaces with dashes and converts _str_ to downcase.
    def jekyll_tagging_slug(str)
      str.to_s.replace_diacritics.downcase.gsub(/\s/, '-')
    end

  end

  class Tagger < Generator

    include Helpers

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
      active_tags.each { |tag, posts| new_tag(tag, posts) }
    end

    def new_tag(tag, posts)
      self.class.types.each { |type|
        if layout = site.config["tag_#{type}_layout"]
          data = { 'layout' => layout, 'posts' => posts.sort.reverse!, 'tag' => tag }
          data.merge!(site.config["tag_#{type}_data"] || {})

          name = yield data if block_given?
          name ||= tag
          name = jekyll_tagging_slug(name)

          tag_dir = site.config["tag_#{type}_dir"]
          tag_dir = File.join(tag_dir, (pretty? ? name : ''))

          page_name = "#{pretty? ? 'index' : name}#{site.layouts[data['layout']].ext}"

          site.pages << TagPage.new(
            site, site.source, tag_dir, page_name, data
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

      tags = active_tags.map { |tag, posts|
        [tag.to_s, range < (size = posts.size) ? range = size : size]
      }


      range = 1..range

      tags.sort!.map! { |tag, size| [tag, range.quantile(size, num)] }
    end

    def active_tags
      return site.tags unless site.config["ignored_tags"]
      site.tags.reject { |t| site.config["ignored_tags"].include? t[0] }
    end

    def pretty?
      @pretty ||= (site.permalink_style == :pretty || site.config['tag_permalink_style'] == 'pretty')
    end

  end

  class TagPage < Page

    def initialize(site, base, dir, name, data = {})
      self.content = data.delete('content') || ''
      self.data    = data

      super(site, base, dir[-1, 1] == '/' ? dir : '/' + dir, name)
    end

    def read_yaml(*)
      # Do nothing
    end

  end

  module TaggingFilters

    include Helpers

    def tag_cloud(site)
      active_tag_data.map { |tag, set|
        tag_link(tag, tag_url(tag), :class => "set-#{set}")
      }.join(' ')
    end

    def tag_link(tag, url = tag_url(tag), html_opts = nil)
      html_opts &&= ' ' << html_opts.map { |k, v| %Q{#{k}="#{v}"} }.join(' ')
      %Q{<a href="#{url}"#{html_opts}>#{tag}</a>}
    end

    def tag_url(tag, type = :page, site = Tagger.site)
      url = File.join('', site.config["baseurl"].to_s, site.config["tag_#{type}_dir"], ERB::Util.u(jekyll_tagging_slug(tag)))
      site.permalink_style == :pretty || site.config['tag_permalink_style'] == 'pretty' ? url << '/' : url << '.html'
    end

    def tags(obj)
      tags = obj['tags'].dup
      tags.map! { |t| t.first } if tags.first.is_a?(Array)
      tags.map! { |t| tag_link(t, tag_url(t), :rel => 'tag') if t.is_a?(String) }.compact!
      tags.join(', ')
    end

    def keywords(obj)
      return '' if not obj['tags']
      tags = obj['tags'].dup
      tags.join(',')
    end

    def active_tag_data(site = Tagger.site)
      return site.config['tag_data'] unless site.config["ignored_tags"]
      site.config["tag_data"].reject { |tag, set| site.config["ignored_tags"].include? tag }
    end
  end

end

Liquid::Template.register_filter(Jekyll::TaggingFilters)
