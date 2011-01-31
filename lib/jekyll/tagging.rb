require 'nuggets/range/quantile'
require 'erb'

module Jekyll

  class Tagger < Generator

    safe true

    DEFAULT_TAG_PAGE_DIR = 'tag'

    def generate(site)
      @tag_page_dir    = site.config['tag_page_dir'] || DEFAULT_TAG_PAGE_DIR
      @tag_page_layout = site.config['tag_page_layout']

      generate_tag_pages(site) if @tag_page_layout
      site.config.update({ 'tag_data' => calculate_tag_cloud(site) })
    end

    # Generates a page per tag and adds them to all the pages of +site+.
    # A <tt>tag_page_layout</tt> have to be defined in your <tt>_config.yml</tt>
    # to use this.
    def generate_tag_pages(site)
      site.tags.each { |tag, posts|
        site.pages << new_tag_page(site, site.source, @tag_page_dir, tag, posts.sort.reverse)
      }
    end

    def new_tag_page(site, base, dir, tag, posts)
      TagPage.new(site, base, dir, "#{tag}.html", {
        'layout' => @tag_page_layout,
        'posts'  => posts,
      })
    end

    # Calculates the css class of every tag for a tag cloud. The possible
    # classes are: set-1..set-5.
    #
    # [[<TAG>, <CLASS>], ...]
    def calculate_tag_cloud(site, num = 5)
      tags = site.tags.map { |tag, posts| [tag, posts.size] }.sort
      range = 1..tags.map { |_, size| size }.max unless tags.empty?

      tags.map { |tag, size| [tag, range.quantile(size, num)] }
    end

  end

  class TagPage < Page

    def initialize(site, base, dir, name, data = {})
      self.content = data.delete('content') || ''
      self.data    = data

      dir = dir[-1, 1] == '/' ? dir : '/' + dir

      super(site, base, dir, name)

      self.data['tag'] = basename
    end

    def read_yaml(_, __)
      # Do nothing
    end

  end

  module Filters

    def tag_cloud(site)
      dir = site['tag_page_dir']

      site['tag_data'].map { |tag, set|
        tag_link(tag, tag_url(tag, dir), { :class => "set-#{set}" })
      }.join(' ')
    end

    def tag_link(tag, url = tag_url(tag), html_opts = nil)
      unless html_opts.nil?
        html_opts = ' ' + html_opts.map { |k, v| %Q{#{k}="#{v}"} }.join(' ')
      end
      %Q{<a href="#{url}"#{html_opts}>#{tag}</a>}
    end

    def tag_url(tag, dir = Tagger::DEFAULT_TAG_PAGE_DIR)
      "/#{dir}/#{ERB::Util.u(tag)}.html"
    end

    def tags(obj)
      tags = obj['tags'][0].is_a?(Array) ? obj['tags'].map{ |t| t[0]} : obj['tags']
      tags.map { |t| tag_link(t, tag_url(t)) if t.is_a?(String) }.compact.join(', ')
    end

  end

end
