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
      site.tags.each { |t|
        site.pages << new_tag_page(site, site.source, @tag_page_dir, t[0], t[1])
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
      range = 1..tags.map { |_, size| size }.max

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
        tag_link(tag, set, tag_url(tag, dir))
      }.join(' ')
    end

    def tag_link(tag, set, url = tag_url(tag))
      %Q{<a href="#{url}" class="set-#{set}">#{tag}</a>}
    end

    def tag_url(tag, dir = DEFAULT_TAG_PAGE_DIR)
      "/#{dir}/#{ERB::Util.u(tag)}.html"
    end

  end

end
