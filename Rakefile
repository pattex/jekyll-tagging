require %q{lib/jekyll/tagging/version}

begin
  require 'hen'

  Hen.lay! {{
    :gem => {
      :name         => %q{jekyll-tagging},
      :version      => Jekyll::Tagging::VERSION,
      :summary      => %q{Jekyll plugin to automatically generate a tag cloud and tag pages.},
      :files        => FileList['lib/**/*.rb'].to_a,
      :extra_files  => FileList['[A-Z]*'].to_a,
      :dependencies => %w[ruby-nuggets],
      :authors      => ['Arne Eilermann', 'Jens Wille'],
      :email        => ['eilermann@lavabit.com', 'jens.wille@uni-koeln.de'],
      :homepage     => %q{http://github.com/pattex/jekyll-tagging}
    }
  }}
rescue LoadError
  warn "Please install the `hen' gem."
end

### Place your custom Rake tasks here.

begin
  require 'jekyll/testtasks/rake'
rescue LoadError
  warn "Please install the `jekyll-testtasks' gem."
end
