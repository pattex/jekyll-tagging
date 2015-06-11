# -*- encoding: utf-8 -*-
# stub: jekyll-tagging 1.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "jekyll-tagging"
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Arne Eilermann", "Jens Wille"]
  s.date = "2015-06-11"
  s.description = "Jekyll plugin to automatically generate a tag cloud and tag pages."
  s.email = ["arne@kleinerdrei.net", "jens.wille@uni-koeln.de"]
  s.extra_rdoc_files = ["ChangeLog"]
  s.files = ["ChangeLog", "README.rdoc", "Rakefile", "lib/jekyll/tagging.rb", "lib/jekyll/tagging/version.rb"]
  s.homepage = "http://github.com/pattex/jekyll-tagging"
  s.licenses = ["MIT"]
  s.post_install_message = "\njekyll-tagging-1.0.1 [2015-06-11]:\n\n* Substitution of non ASCII characters and whitespaces, also when 'tag_permalink_style: pretty'.\n\n"
  s.rdoc_options = ["--title", "jekyll-tagging Application documentation (v1.0.1)", "--charset", "UTF-8", "--line-numbers", "--all", "--main", "ChangeLog"]
  s.rubygems_version = "2.4.6"
  s.summary = "Jekyll plugin to automatically generate a tag cloud and tag pages."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ruby-nuggets>, [">= 0"])
      s.add_development_dependency(%q<hen>, [">= 0.8.1", "~> 0.8"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<ruby-nuggets>, [">= 0"])
      s.add_dependency(%q<hen>, [">= 0.8.1", "~> 0.8"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<ruby-nuggets>, [">= 0"])
    s.add_dependency(%q<hen>, [">= 0.8.1", "~> 0.8"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
