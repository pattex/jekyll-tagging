# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "jekyll-tagging"
  s.version = "0.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Arne Eilermann", "Jens Wille"]
  s.date = "2013-07-15"
  s.description = "Jekyll plugin to automatically generate a tag cloud and tag pages."
  s.email = ["eilermann@lavabit.com", "jens.wille@uni-koeln.de"]
  s.extra_rdoc_files = ["ChangeLog"]
  s.files = ["lib/jekyll/tagging.rb", "lib/jekyll/tagging/version.rb", "ChangeLog", "README.rdoc", "Rakefile"]
  s.homepage = "http://github.com/pattex/jekyll-tagging"
  s.licenses = ["MIT"]
  s.rdoc_options = ["--charset", "UTF-8", "--line-numbers", "--all", "--title", "jekyll-tagging Application documentation (v0.5.0)", "--main", "ChangeLog"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.5"
  s.summary = "Jekyll plugin to automatically generate a tag cloud and tag pages."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ruby-nuggets>, [">= 0"])
      s.add_runtime_dependency(%q<stringex>, [">= 0"])
    else
      s.add_dependency(%q<ruby-nuggets>, [">= 0"])
      s.add_dependency(%q<stringex>, [">= 0"])
    end
  else
    s.add_dependency(%q<ruby-nuggets>, [">= 0"])
    s.add_dependency(%q<stringex>, [">= 0"])
  end
end
