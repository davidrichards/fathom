=begin

  Build Discrete Uniform Factor
  ============================

  Data

  * variable definitions ({label => [domain]})
  * factor

  Primary Course

  User provides variable definitions
  System creates uniform probabilities
  System returns a factor

=end

require File.expand_path('../build_factor_base', __FILE__)
module Fathom

  class BuildDiscreteUniformFactor < BuildFactorBase

    attr_reader :target_variable, :parent_variables

    def initialize(target_variable, parent_variables=[])
      @target_variable = target_variable
      @parent_variables = Array(parent_variables)
    end

    def target_label
      @target_label ||= target_variable.label
    end
    alias_method :label, :target_label
    alias_method :target, :target_variable

    def variables
      @variables ||= [target_variable] + parent_variables
    end

    def parent_labels
      @parent_labels ||= parent_variables.map(&:label)
    end

    def probability_table
      size = table_keys.size
      @probability_table ||= table_keys.inject({}) do |hash, key|
        hash[key] = 1.0 / size
        hash
      end
    end

    def factor
      @factor ||= Factor.new({
       label: label,
       parents: parent_labels,
       type: 'discrete',
       table: probability_table
      })
    end
    alias_method :execute!, :factor

    def inspect
      "BuildDiscreteUniformFactor #{label} from #{parent_labels}"
    end

  end

end
