require File.expand_path(%q{../lib/jekyll/tagging/version}, __FILE__)

begin
  require 'hen'

  Hen.lay! {{
    :gem => {
      :name         => %q{jekyll-tagging},
      :version      => Jekyll::Tagging::VERSION,
      :summary      => %q{Jekyll plugin to automatically generate a tag cloud and tag pages.},
      :authors      => ['Arne Eilermann', 'Jens Wille'],
      :email        => ['arne@kleinerdrei.net', 'jens.wille@uni-koeln.de'],
      :license      => %q{MIT},
      :homepage     => :pattex,
      :dependencies => %w[nuggets]
    }
  }}
rescue LoadError => err
  warn "Please install the `hen' gem. (#{err})"
end

begin
  require 'jekyll/testtasks/rake'
rescue LoadError => err
  warn "Please install the `jekyll-testtasks' gem. (#{err})"
end
