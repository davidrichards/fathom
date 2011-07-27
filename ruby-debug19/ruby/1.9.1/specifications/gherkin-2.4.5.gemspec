# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{gherkin}
  s.version = "2.4.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mike Sassak", "Gregory Hnatiuk", "Aslak HellesÃ¸y"]
  s.date = %q{2011-07-10}
  s.description = %q{A fast Gherkin lexer/parser for based on the Ragel State Machine Compiler.}
  s.email = %q{cukes@googlegroups.com}
  s.extensions = ["ext/gherkin_lexer_ar/extconf.rb", "ext/gherkin_lexer_bg/extconf.rb", "ext/gherkin_lexer_ca/extconf.rb", "ext/gherkin_lexer_cs/extconf.rb", "ext/gherkin_lexer_cy_gb/extconf.rb", "ext/gherkin_lexer_da/extconf.rb", "ext/gherkin_lexer_de/extconf.rb", "ext/gherkin_lexer_en/extconf.rb", "ext/gherkin_lexer_en_au/extconf.rb", "ext/gherkin_lexer_en_lol/extconf.rb", "ext/gherkin_lexer_en_pirate/extconf.rb", "ext/gherkin_lexer_en_scouse/extconf.rb", "ext/gherkin_lexer_en_tx/extconf.rb", "ext/gherkin_lexer_eo/extconf.rb", "ext/gherkin_lexer_es/extconf.rb", "ext/gherkin_lexer_et/extconf.rb", "ext/gherkin_lexer_fi/extconf.rb", "ext/gherkin_lexer_fr/extconf.rb", "ext/gherkin_lexer_he/extconf.rb", "ext/gherkin_lexer_hr/extconf.rb", "ext/gherkin_lexer_hu/extconf.rb", "ext/gherkin_lexer_id/extconf.rb", "ext/gherkin_lexer_it/extconf.rb", "ext/gherkin_lexer_ja/extconf.rb", "ext/gherkin_lexer_ko/extconf.rb", "ext/gherkin_lexer_lt/extconf.rb", "ext/gherkin_lexer_lu/extconf.rb", "ext/gherkin_lexer_lv/extconf.rb", "ext/gherkin_lexer_nl/extconf.rb", "ext/gherkin_lexer_no/extconf.rb", "ext/gherkin_lexer_pl/extconf.rb", "ext/gherkin_lexer_pt/extconf.rb", "ext/gherkin_lexer_ro/extconf.rb", "ext/gherkin_lexer_ru/extconf.rb", "ext/gherkin_lexer_sk/extconf.rb", "ext/gherkin_lexer_sr_cyrl/extconf.rb", "ext/gherkin_lexer_sr_latn/extconf.rb", "ext/gherkin_lexer_sv/extconf.rb", "ext/gherkin_lexer_tr/extconf.rb", "ext/gherkin_lexer_uk/extconf.rb", "ext/gherkin_lexer_uz/extconf.rb", "ext/gherkin_lexer_vi/extconf.rb", "ext/gherkin_lexer_zh_cn/extconf.rb", "ext/gherkin_lexer_zh_tw/extconf.rb"]
  s.files = ["features/escaped_pipes.feature", "features/feature_parser.feature", "features/json_formatter.feature", "features/json_parser.feature", "features/native_lexer.feature", "features/parser_with_native_lexer.feature", "features/pretty_formatter.feature", "features/step_definitions/eyeball_steps.rb", "features/step_definitions/gherkin_steps.rb", "features/step_definitions/json_formatter_steps.rb", "features/step_definitions/json_parser_steps.rb", "features/step_definitions/pretty_formatter_steps.rb", "features/steps_parser.feature", "features/support/env.rb", "spec/gherkin/c_lexer_spec.rb", "spec/gherkin/fixtures/1.feature", "spec/gherkin/fixtures/comments_in_table.feature", "spec/gherkin/fixtures/complex.feature", "spec/gherkin/fixtures/complex.json", "spec/gherkin/fixtures/complex_for_filtering.feature", "spec/gherkin/fixtures/complex_with_tags.feature", "spec/gherkin/fixtures/dos_line_endings.feature", "spec/gherkin/fixtures/hantu_pisang.feature", "spec/gherkin/fixtures/i18n_fr.feature", "spec/gherkin/fixtures/i18n_no.feature", "spec/gherkin/fixtures/i18n_zh-CN.feature", "spec/gherkin/fixtures/scenario_outline_with_tags.feature", "spec/gherkin/fixtures/scenario_without_steps.feature", "spec/gherkin/fixtures/simple_with_comments.feature", "spec/gherkin/fixtures/simple_with_tags.feature", "spec/gherkin/fixtures/with_bom.feature", "spec/gherkin/formatter/ansi_escapes_spec.rb", "spec/gherkin/formatter/filter_formatter_spec.rb", "spec/gherkin/formatter/model_spec.rb", "spec/gherkin/formatter/pretty_formatter_spec.rb", "spec/gherkin/formatter/spaces.feature", "spec/gherkin/formatter/step_printer_spec.rb", "spec/gherkin/formatter/tabs.feature", "spec/gherkin/formatter/tag_count_formatter_spec.rb", "spec/gherkin/i18n_spec.rb", "spec/gherkin/java_lexer_spec.rb", "spec/gherkin/java_libs.rb", "spec/gherkin/js_lexer_spec.rb", "spec/gherkin/json_parser_spec.rb", "spec/gherkin/lexer/i18n_lexer_spec.rb", "spec/gherkin/output_stream_string_io.rb", "spec/gherkin/parser/parser_spec.rb", "spec/gherkin/rb_lexer_spec.rb", "spec/gherkin/sexp_recorder.rb", "spec/gherkin/shared/bom_group.rb", "spec/gherkin/shared/doc_string_group.rb", "spec/gherkin/shared/lexer_group.rb", "spec/gherkin/shared/row_group.rb", "spec/gherkin/shared/tags_group.rb", "spec/gherkin/tag_expression_spec.rb", "spec/spec_helper.rb", "ext/gherkin_lexer_ar/extconf.rb", "ext/gherkin_lexer_bg/extconf.rb", "ext/gherkin_lexer_ca/extconf.rb", "ext/gherkin_lexer_cs/extconf.rb", "ext/gherkin_lexer_cy_gb/extconf.rb", "ext/gherkin_lexer_da/extconf.rb", "ext/gherkin_lexer_de/extconf.rb", "ext/gherkin_lexer_en/extconf.rb", "ext/gherkin_lexer_en_au/extconf.rb", "ext/gherkin_lexer_en_lol/extconf.rb", "ext/gherkin_lexer_en_pirate/extconf.rb", "ext/gherkin_lexer_en_scouse/extconf.rb", "ext/gherkin_lexer_en_tx/extconf.rb", "ext/gherkin_lexer_eo/extconf.rb", "ext/gherkin_lexer_es/extconf.rb", "ext/gherkin_lexer_et/extconf.rb", "ext/gherkin_lexer_fi/extconf.rb", "ext/gherkin_lexer_fr/extconf.rb", "ext/gherkin_lexer_he/extconf.rb", "ext/gherkin_lexer_hr/extconf.rb", "ext/gherkin_lexer_hu/extconf.rb", "ext/gherkin_lexer_id/extconf.rb", "ext/gherkin_lexer_it/extconf.rb", "ext/gherkin_lexer_ja/extconf.rb", "ext/gherkin_lexer_ko/extconf.rb", "ext/gherkin_lexer_lt/extconf.rb", "ext/gherkin_lexer_lu/extconf.rb", "ext/gherkin_lexer_lv/extconf.rb", "ext/gherkin_lexer_nl/extconf.rb", "ext/gherkin_lexer_no/extconf.rb", "ext/gherkin_lexer_pl/extconf.rb", "ext/gherkin_lexer_pt/extconf.rb", "ext/gherkin_lexer_ro/extconf.rb", "ext/gherkin_lexer_ru/extconf.rb", "ext/gherkin_lexer_sk/extconf.rb", "ext/gherkin_lexer_sr_cyrl/extconf.rb", "ext/gherkin_lexer_sr_latn/extconf.rb", "ext/gherkin_lexer_sv/extconf.rb", "ext/gherkin_lexer_tr/extconf.rb", "ext/gherkin_lexer_uk/extconf.rb", "ext/gherkin_lexer_uz/extconf.rb", "ext/gherkin_lexer_vi/extconf.rb", "ext/gherkin_lexer_zh_cn/extconf.rb", "ext/gherkin_lexer_zh_tw/extconf.rb"]
  s.homepage = %q{http://github.com/cucumber/gherkin}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{gherkin-2.4.5}
  s.test_files = ["features/escaped_pipes.feature", "features/feature_parser.feature", "features/json_formatter.feature", "features/json_parser.feature", "features/native_lexer.feature", "features/parser_with_native_lexer.feature", "features/pretty_formatter.feature", "features/step_definitions/eyeball_steps.rb", "features/step_definitions/gherkin_steps.rb", "features/step_definitions/json_formatter_steps.rb", "features/step_definitions/json_parser_steps.rb", "features/step_definitions/pretty_formatter_steps.rb", "features/steps_parser.feature", "features/support/env.rb", "spec/gherkin/c_lexer_spec.rb", "spec/gherkin/fixtures/1.feature", "spec/gherkin/fixtures/comments_in_table.feature", "spec/gherkin/fixtures/complex.feature", "spec/gherkin/fixtures/complex.json", "spec/gherkin/fixtures/complex_for_filtering.feature", "spec/gherkin/fixtures/complex_with_tags.feature", "spec/gherkin/fixtures/dos_line_endings.feature", "spec/gherkin/fixtures/hantu_pisang.feature", "spec/gherkin/fixtures/i18n_fr.feature", "spec/gherkin/fixtures/i18n_no.feature", "spec/gherkin/fixtures/i18n_zh-CN.feature", "spec/gherkin/fixtures/scenario_outline_with_tags.feature", "spec/gherkin/fixtures/scenario_without_steps.feature", "spec/gherkin/fixtures/simple_with_comments.feature", "spec/gherkin/fixtures/simple_with_tags.feature", "spec/gherkin/fixtures/with_bom.feature", "spec/gherkin/formatter/ansi_escapes_spec.rb", "spec/gherkin/formatter/filter_formatter_spec.rb", "spec/gherkin/formatter/model_spec.rb", "spec/gherkin/formatter/pretty_formatter_spec.rb", "spec/gherkin/formatter/spaces.feature", "spec/gherkin/formatter/step_printer_spec.rb", "spec/gherkin/formatter/tabs.feature", "spec/gherkin/formatter/tag_count_formatter_spec.rb", "spec/gherkin/i18n_spec.rb", "spec/gherkin/java_lexer_spec.rb", "spec/gherkin/java_libs.rb", "spec/gherkin/js_lexer_spec.rb", "spec/gherkin/json_parser_spec.rb", "spec/gherkin/lexer/i18n_lexer_spec.rb", "spec/gherkin/output_stream_string_io.rb", "spec/gherkin/parser/parser_spec.rb", "spec/gherkin/rb_lexer_spec.rb", "spec/gherkin/sexp_recorder.rb", "spec/gherkin/shared/bom_group.rb", "spec/gherkin/shared/doc_string_group.rb", "spec/gherkin/shared/lexer_group.rb", "spec/gherkin/shared/row_group.rb", "spec/gherkin/shared/tags_group.rb", "spec/gherkin/tag_expression_spec.rb", "spec/spec_helper.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake-compiler>, [">= 0.7.8"])
      s.add_runtime_dependency(%q<json>, [">= 1.4.6"])
      s.add_development_dependency(%q<cucumber>, [">= 1.0.0"])
      s.add_development_dependency(%q<rake>, [">= 0.9.2"])
      s.add_development_dependency(%q<bundler>, [">= 1.0.15"])
      s.add_development_dependency(%q<rspec>, [">= 2.6.0"])
      s.add_development_dependency(%q<awesome_print>, [">= 0.4.0"])
      s.add_development_dependency(%q<therubyracer>, [">= 0.9.2"])
      s.add_development_dependency(%q<yard>, [">= 0.7.2"])
      s.add_development_dependency(%q<rdiscount>, [">= 1.6.8"])
      s.add_development_dependency(%q<term-ansicolor>, [">= 1.0.5"])
      s.add_development_dependency(%q<builder>, [">= 2.1.2"])
    else
      s.add_dependency(%q<rake-compiler>, [">= 0.7.8"])
      s.add_dependency(%q<json>, [">= 1.4.6"])
      s.add_dependency(%q<cucumber>, [">= 1.0.0"])
      s.add_dependency(%q<rake>, [">= 0.9.2"])
      s.add_dependency(%q<bundler>, [">= 1.0.15"])
      s.add_dependency(%q<rspec>, [">= 2.6.0"])
      s.add_dependency(%q<awesome_print>, [">= 0.4.0"])
      s.add_dependency(%q<therubyracer>, [">= 0.9.2"])
      s.add_dependency(%q<yard>, [">= 0.7.2"])
      s.add_dependency(%q<rdiscount>, [">= 1.6.8"])
      s.add_dependency(%q<term-ansicolor>, [">= 1.0.5"])
      s.add_dependency(%q<builder>, [">= 2.1.2"])
    end
  else
    s.add_dependency(%q<rake-compiler>, [">= 0.7.8"])
    s.add_dependency(%q<json>, [">= 1.4.6"])
    s.add_dependency(%q<cucumber>, [">= 1.0.0"])
    s.add_dependency(%q<rake>, [">= 0.9.2"])
    s.add_dependency(%q<bundler>, [">= 1.0.15"])
    s.add_dependency(%q<rspec>, [">= 2.6.0"])
    s.add_dependency(%q<awesome_print>, [">= 0.4.0"])
    s.add_dependency(%q<therubyracer>, [">= 0.9.2"])
    s.add_dependency(%q<yard>, [">= 0.7.2"])
    s.add_dependency(%q<rdiscount>, [">= 1.6.8"])
    s.add_dependency(%q<term-ansicolor>, [">= 1.0.5"])
    s.add_dependency(%q<builder>, [">= 2.1.2"])
  end
end
