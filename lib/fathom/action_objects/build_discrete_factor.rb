=begin

  Build Discrete Factor
  =====================

  Data

  * variables
  * parent_labels
  * observations (CSV)
  * factor

  Primary Course

  User provides variable definitions and observations
  System updates the frequencies from observations
  System replaces zeroes with the default probability (1 / 3 orders of magnitude greater than the observation size)
  System normalizes the frequency table into a probability table
  System returns a factor

=end

require File.expand_path('../build_factor_base', __FILE__)
module Fathom

  class BuildDiscreteFactor < BuildFactorBase

    attr_reader :variables, :parent_labels, :observations

    def initialize(variables, parent_labels, observations)
      @variables     = Array(variables)
      @parent_labels = Array(parent_labels)
      @observations  = observations
    end

    def frequency_table
      @frequency_table ||= data.inject(empty_table(0)) do |hash, row|
        hash[key_for(row)] += 1
        hash
      end
    end

    def probability_table
      @probability_table ||= NormalizeTable.execute!(frequency_table, zero)
    end

    def factor
      @factor ||= Factor.new({
       label:     label,
       target:    target,
       parents:   parent_labels,
       type:      'discrete',
       table:     probability_table
      })
    end
    alias_method :execute!, :factor

    def inspect
      "BuildDiscreteFactor (#{size}) #{label} from #{parent_labels}"
    end

    protected

    def key_for(row)
      variable_labels.inject({}) do |hash, label|
        index = header.index(label)
        hash[label] = row[index]
        hash
      end
    end

    def empty_table(default=nil)
      table_keys.inject(Hash.new(default)) do |hash, key|
        hash[key] = default
        hash
      end
    end

    def size
      @size ||= data.size
    end

    def zero
      ceiling_order_of_magnitude = Math.log10(size).ceil
      three_orders_more = 3 + ceiling_order_of_magnitude
      numerator = 10 ** three_orders_more
      1.0 / numerator
    end

    def header
      @header ||= observations[0]
    end

    def data
      @data ||= observations[1..-1]
    end

  end

end
