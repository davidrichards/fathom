# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rspec-expectations}
  s.version = "2.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["David Chelimsky", "Chad Humphries"]
  s.date = %q{2010-12-11}
  s.description = %q{rspec expectations (should[_not] and matchers)}
  s.email = %q{dchelimsky@gmail.com;chad.humphries@gmail.com}
  s.files = ["features/README.markdown", "features/expectations/attribute_of_subject.feature", "features/expectations/customized_message.feature", "features/expectations/diffing.feature", "features/expectations/implicit_docstrings.feature", "features/matchers/access_running_example.feature", "features/matchers/be.feature", "features/matchers/be_within.feature", "features/matchers/define_diffable_matcher.feature", "features/matchers/define_matcher.feature", "features/matchers/define_matcher_outside_rspec.feature", "features/matchers/define_matcher_with_fluent_interface.feature", "features/matchers/equality.feature", "features/matchers/exist.feature", "features/matchers/expect_change.feature", "features/matchers/expect_error.feature", "features/matchers/have.feature", "features/matchers/include.feature", "features/matchers/match.feature", "features/matchers/operators.feature", "features/matchers/predicates.feature", "features/matchers/respond_to.feature", "features/matchers/satisfy.feature", "features/matchers/throw_symbol.feature", "features/matchers/types.feature", "features/step_definitions/additional_cli_steps.rb", "features/support/env.rb", "features/test_frameworks/test_unit.feature", "spec/rspec/expectations/differ_spec.rb", "spec/rspec/expectations/extensions/kernel_spec.rb", "spec/rspec/expectations/fail_with_spec.rb", "spec/rspec/expectations/handler_spec.rb", "spec/rspec/matchers/be_close_spec.rb", "spec/rspec/matchers/be_instance_of_spec.rb", "spec/rspec/matchers/be_kind_of_spec.rb", "spec/rspec/matchers/be_spec.rb", "spec/rspec/matchers/be_within_spec.rb", "spec/rspec/matchers/change_spec.rb", "spec/rspec/matchers/compatibility_spec.rb", "spec/rspec/matchers/description_generation_spec.rb", "spec/rspec/matchers/dsl_spec.rb", "spec/rspec/matchers/eq_spec.rb", "spec/rspec/matchers/eql_spec.rb", "spec/rspec/matchers/equal_spec.rb", "spec/rspec/matchers/exist_spec.rb", "spec/rspec/matchers/has_spec.rb", "spec/rspec/matchers/have_spec.rb", "spec/rspec/matchers/include_spec.rb", "spec/rspec/matchers/match_array_spec.rb", "spec/rspec/matchers/match_spec.rb", "spec/rspec/matchers/matcher_spec.rb", "spec/rspec/matchers/matchers_spec.rb", "spec/rspec/matchers/operator_matcher_spec.rb", "spec/rspec/matchers/raise_error_spec.rb", "spec/rspec/matchers/respond_to_spec.rb", "spec/rspec/matchers/satisfy_spec.rb", "spec/rspec/matchers/throw_symbol_spec.rb", "spec/spec_helper.rb", "spec/suite.rb", "spec/support/classes.rb", "spec/support/matchers.rb", "spec/support/ruby_version.rb"]
  s.homepage = %q{http://github.com/rspec/rspec-expectations}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{rspec}
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{rspec-expectations-2.3.0}
  s.test_files = ["features/README.markdown", "features/expectations/attribute_of_subject.feature", "features/expectations/customized_message.feature", "features/expectations/diffing.feature", "features/expectations/implicit_docstrings.feature", "features/matchers/access_running_example.feature", "features/matchers/be.feature", "features/matchers/be_within.feature", "features/matchers/define_diffable_matcher.feature", "features/matchers/define_matcher.feature", "features/matchers/define_matcher_outside_rspec.feature", "features/matchers/define_matcher_with_fluent_interface.feature", "features/matchers/equality.feature", "features/matchers/exist.feature", "features/matchers/expect_change.feature", "features/matchers/expect_error.feature", "features/matchers/have.feature", "features/matchers/include.feature", "features/matchers/match.feature", "features/matchers/operators.feature", "features/matchers/predicates.feature", "features/matchers/respond_to.feature", "features/matchers/satisfy.feature", "features/matchers/throw_symbol.feature", "features/matchers/types.feature", "features/step_definitions/additional_cli_steps.rb", "features/support/env.rb", "features/test_frameworks/test_unit.feature", "spec/rspec/expectations/differ_spec.rb", "spec/rspec/expectations/extensions/kernel_spec.rb", "spec/rspec/expectations/fail_with_spec.rb", "spec/rspec/expectations/handler_spec.rb", "spec/rspec/matchers/be_close_spec.rb", "spec/rspec/matchers/be_instance_of_spec.rb", "spec/rspec/matchers/be_kind_of_spec.rb", "spec/rspec/matchers/be_spec.rb", "spec/rspec/matchers/be_within_spec.rb", "spec/rspec/matchers/change_spec.rb", "spec/rspec/matchers/compatibility_spec.rb", "spec/rspec/matchers/description_generation_spec.rb", "spec/rspec/matchers/dsl_spec.rb", "spec/rspec/matchers/eq_spec.rb", "spec/rspec/matchers/eql_spec.rb", "spec/rspec/matchers/equal_spec.rb", "spec/rspec/matchers/exist_spec.rb", "spec/rspec/matchers/has_spec.rb", "spec/rspec/matchers/have_spec.rb", "spec/rspec/matchers/include_spec.rb", "spec/rspec/matchers/match_array_spec.rb", "spec/rspec/matchers/match_spec.rb", "spec/rspec/matchers/matcher_spec.rb", "spec/rspec/matchers/matchers_spec.rb", "spec/rspec/matchers/operator_matcher_spec.rb", "spec/rspec/matchers/raise_error_spec.rb", "spec/rspec/matchers/respond_to_spec.rb", "spec/rspec/matchers/satisfy_spec.rb", "spec/rspec/matchers/throw_symbol_spec.rb", "spec/spec_helper.rb", "spec/suite.rb", "spec/support/classes.rb", "spec/support/matchers.rb", "spec/support/ruby_version.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<diff-lcs>, ["~> 1.1.2"])
    else
      s.add_dependency(%q<diff-lcs>, ["~> 1.1.2"])
    end
  else
    s.add_dependency(%q<diff-lcs>, ["~> 1.1.2"])
  end
end
