require File.expand_path('../action_object', __FILE__)

module Fathom
  class NormalizeTable < ActionObject

    attr_reader :table, :zero

    def initialize(table, zero=0.0)
      @table = table
      @zero = zero
      assert_zeroes!
    end

    def normalize!
      table.inject({}) do |hash, (key, value)|
        hash[key] = Rational(table[key], pre_normalized_sum)
        hash
      end
    end
    alias_method :execute!, :normalize!

    protected

    def pre_normalized_sum
      @pre_normalized_sum ||= table.inject(0.0) { |s, (k, v)| s + v }
    end

    def assert_zeroes!
      @table = table.inject({}) do |hash, (key, value)|
        hash[key] = (value.zero? ? zero : value)
        hash
      end
    end

  end
end
