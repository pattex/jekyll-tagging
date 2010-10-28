require 'nuggets/range/quantile'
require 'erb'

module Jekyll

  class Tagger < Generator

    safe true

    def generate(site)
      @tag_page_dir    = site.config['tag_page_dir'] || 'tag'
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
    def calculate_tag_cloud(site)
      tag_data = []
      max   = site.tags.map { |t| t[1].size }.max
      site.tags.sort.each { |t|
        quant = (1..max).quantile(t[1].size, 5)
        tag_data << [t[0], "set-#{quant}"]
      }
      tag_data
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
      site['tag_data'].collect { |t|
        "<a href=\"/#{site['tag_page_dir']}/#{ERB::Util.u(t[0])}.html\" class=\"#{t[1]}\">#{t[0]}</a>"
      }.join(' ')
    end

  end

end
