# -*- encoding: utf-8 -*-
# stub: jekyll-tagging 1.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "jekyll-tagging".freeze
  s.version = "1.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Arne Eilermann".freeze, "Jens Wille".freeze]
  s.date = "2017-03-07"
  s.description = "Jekyll plugin to automatically generate a tag cloud and tag pages.".freeze
  s.email = ["arne@kleinerdrei.net".freeze, "jens.wille@uni-koeln.de".freeze]
  s.extra_rdoc_files = ["ChangeLog".freeze]
  s.files = ["ChangeLog".freeze, "README.rdoc".freeze, "Rakefile".freeze, "lib/jekyll/tagging.rb".freeze, "lib/jekyll/tagging/version.rb".freeze]
  s.homepage = "http://github.com/pattex/jekyll-tagging".freeze
  s.licenses = ["MIT".freeze]
  s.post_install_message = "\njekyll-tagging-1.1.0 [2017-03-07]:\n\n* Added ability to append extra data to all tag pages. (tfe)\n* Provides compatibility to the current jekyll (3.4.1).\n* A few fixes. (felipe)\n* Some documentation improvements. (wsmoak, jonathanpberger)\n* Prooves who is the worst open source maintainer. (pattex ^__^)\n\n".freeze
  s.rdoc_options = ["--title".freeze, "jekyll-tagging Application documentation (v1.1.0)".freeze, "--charset".freeze, "UTF-8".freeze, "--line-numbers".freeze, "--all".freeze, "--main".freeze, "ChangeLog".freeze]
  s.rubygems_version = "2.6.10".freeze
  s.summary = "Jekyll plugin to automatically generate a tag cloud and tag pages.".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nuggets>.freeze, [">= 0"])
      s.add_development_dependency(%q<hen>.freeze, [">= 0.8.7", "~> 0.8"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    else
      s.add_dependency(%q<nuggets>.freeze, [">= 0"])
      s.add_dependency(%q<hen>.freeze, [">= 0.8.7", "~> 0.8"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<nuggets>.freeze, [">= 0"])
    s.add_dependency(%q<hen>.freeze, [">= 0.8.7", "~> 0.8"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
