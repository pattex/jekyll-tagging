# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{jekyll-tagging}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Arne Eilermann", "Jens Wille"]
  s.date = %q{2011-03-10}
  s.description = %q{Jekyll plugin to automatically generate a tag cloud and tag pages.}
  s.email = ["eilermann@lavabit.com", "jens.wille@uni-koeln.de"]
  s.extra_rdoc_files = ["ChangeLog"]
  s.files = ["lib/jekyll/tagging/version.rb", "lib/jekyll/tagging.rb", "ChangeLog", "Rakefile", "README.rdoc"]
  s.homepage = %q{http://github.com/pattex/jekyll-tagging}
  s.rdoc_options = ["--all", "--charset", "UTF-8", "--main", "ChangeLog", "--title", "jekyll-tagging Application documentation (v0.2.0)", "--line-numbers"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.5.2}
  s.summary = %q{Jekyll plugin to automatically generate a tag cloud and tag pages.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ruby-nuggets>, [">= 0"])
    else
      s.add_dependency(%q<ruby-nuggets>, [">= 0"])
    end
  else
    s.add_dependency(%q<ruby-nuggets>, [">= 0"])
  end
end
