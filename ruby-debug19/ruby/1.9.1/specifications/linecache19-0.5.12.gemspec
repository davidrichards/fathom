# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{linecache19}
  s.version = "0.5.12"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["R. Bernstein", "Mark Moseley"]
  s.date = %q{2011-04-02}
  s.description = %q{Linecache is a module for reading and caching lines. This may be useful for
example in a debugger where the same lines are shown many times.
}
  s.email = %q{mark@fast-software.com}
  s.extensions = ["ext/trace_nums/extconf.rb"]
  s.files = ["test/test-linecache.rb", "test/test-tracelines.rb", "ext/trace_nums/extconf.rb"]
  s.homepage = %q{http://rubyforge.org/projects/ruby-debug19}
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.2")
  s.rubyforge_project = %q{ruby-debug19}
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Read file with caching}
  s.test_files = ["test/test-linecache.rb", "test/test-tracelines.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ruby_core_source>, [">= 0.1.4"])
    else
      s.add_dependency(%q<ruby_core_source>, [">= 0.1.4"])
    end
  else
    s.add_dependency(%q<ruby_core_source>, [">= 0.1.4"])
  end
end
