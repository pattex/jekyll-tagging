require 'nuggets/range/quantile'
require 'erb'

module Jekyll

  class Tagger < Generator

    safe true

    attr_accessor :site

    @types = [:page, :feed]

    class << self; attr_accessor :types, :site; end

    @@classifiers={
        'log'=>proc{|classes,value,min,max|
          scaled = (classes*(Math.log(value) - Math.log(min))/(Math.log(max) - Math.log(min))).to_i
          scaled == classes ? classes : scaled+1},
        'linear'=>proc{|classes,value,min,max| (1..max).quantile(value, classes)}
    }

    def initialize(config)
      @ignored_tags=config["ignored_tags"] || []
      @threshold=(config["tag_threshold"] || '1').to_i
      @permalink_style=config['tag_permalink_style']
      @classifier=config['tag_classifier'] || 'linear'
    end

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

          name = yield data if block_given?
          name ||= tag

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
      s, t = site, { name => calculate_tag_cloud(@@classifiers[@classifier].curry[num]) }
      s.respond_to?(:add_payload) ? s.add_payload(t) : s.config.update(t)
    end

    # Calculates the css class of every tag for a tag cloud. The possible
    # classes are: set-1..set-5.
    #
    # [[<TAG>, <CLASS>], ...]
    def calculate_tag_cloud(classifier)
      tags = active_tags.map { |tag, posts| [tag, posts.size] }
      min, max = tags.map { |tag, size| size }.minmax
      tags.sort!.map! { |tag, size| [tag, classifier.call(size,min,max)] }
    end

    def active_tags
      site.tags.reject { |tag, posts| @ignored_tags.include? tag or posts.size < @threshold}
    end

    def pretty?
      @pretty ||= (site.permalink_style == :pretty || @permalink_style == 'pretty')
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

  module Filters

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
      url = File.join('', site.config["tag_#{type}_dir"], ERB::Util.u(tag))
      site.permalink_style == :pretty || site.config['tag_permalink_style'] == 'pretty' ? url : url << '.html'
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
      return site.config['tag_data']
    end
  end

end
