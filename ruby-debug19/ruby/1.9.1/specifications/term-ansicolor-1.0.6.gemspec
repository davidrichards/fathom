# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{term-ansicolor}
  s.version = "1.0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Florian Frank"]
  s.date = %q{2011-07-21}
  s.description = %q{}
  s.email = %q{flori@ping.de}
  s.executables = ["decolor", "cdiff"]
  s.files = ["tests/ansicolor_test.rb", "bin/decolor", "bin/cdiff"]
  s.homepage = %q{http://flori.github.com/term-ansicolor}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Ruby library that colors strings using ANSI escape sequences}
  s.test_files = ["tests/ansicolor_test.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<gem_hadar>, ["~> 0.0.8"])
    else
      s.add_dependency(%q<gem_hadar>, ["~> 0.0.8"])
    end
  else
    s.add_dependency(%q<gem_hadar>, ["~> 0.0.8"])
  end
end
