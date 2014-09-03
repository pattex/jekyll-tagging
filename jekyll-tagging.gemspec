# -*- encoding: utf-8 -*-
# stub: jekyll-tagging 0.6.0 ruby lib

Gem::Specification.new do |s|
  s.name = "jekyll-tagging"
  s.version = "0.6.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Arne Eilermann", "Jens Wille"]
  s.date = "2014-09-03"
  s.description = "Jekyll plugin to automatically generate a tag cloud and tag pages."
  s.email = ["eilermann@lavabit.com", "jens.wille@uni-koeln.de"]
  s.extra_rdoc_files = ["ChangeLog"]
  s.files = ["ChangeLog", "README.rdoc", "Rakefile", "lib/jekyll/tagging.rb", "lib/jekyll/tagging/version.rb"]
  s.homepage = "http://github.com/pattex/jekyll-tagging"
  s.licenses = ["MIT"]
  s.post_install_message = "\njekyll-tagging-0.6.0 [2014-09-03]:\n\n* Pretty permalinks for tag pages. (Steve Valaitis)\n* Added support for keywords (allenlsy)\n\n"
  s.rdoc_options = ["--title", "jekyll-tagging Application documentation (v0.6.0)", "--charset", "UTF-8", "--line-numbers", "--all", "--main", "ChangeLog"]
  s.rubygems_version = "2.4.1"
  s.summary = "Jekyll plugin to automatically generate a tag cloud and tag pages."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ruby-nuggets>, [">= 0"])
    else
      s.add_dependency(%q<ruby-nuggets>, [">= 0"])
    end
  else
    s.add_dependency(%q<ruby-nuggets>, [">= 0"])
  end
end
