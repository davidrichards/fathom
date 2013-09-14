=begin

  Build Discrete Uniform Factor
  =====================

  Data

  * variable definitions ({label => [values]})
  * factor

  Primary Course

  User provides variable definitions
  System creates uniform probabilities
  System returns a factor

=end

require File.expand_path('../build_factor_base', __FILE__)
module Fathom

  class BuildDiscreteUniformFactor < BuildFactorBase

    attr_reader :variables

    def initialize(variables)
      @variables    = variables
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
       properties: parent_labels,
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
