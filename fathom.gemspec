Gem::Specification.new do |s|
  s.name = "fathom"
  s.version = "0.6.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["David Richards"]
  s.date = "2011-10-31"
  s.description = "A framework for building analytical models in Ruby and supporting systems.  This is meant to be a flexible tool for many kinds of models, and should grow gently over time."
  s.email = "davidlamontrichards@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    "lib/fathom.rb"
  ]
  s.homepage = "http://github.com/davidrichards/fathom"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.11"
  s.summary = "Decision support in Ruby"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<uuid>, [">= 0"])
    else
      s.add_dependency(%q<uuid>, [">= 0"])
    end
  else
    s.add_dependency(%q<uuid>, [">= 0"])
  end
end
