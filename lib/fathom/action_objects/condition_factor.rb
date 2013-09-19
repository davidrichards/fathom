require File.expand_path('../action_object', __FILE__)

module Fathom
  class ConditionFactor < ActionObject

    attr_reader :factor, :query

    def initialize(factor, query)
      @factor, @query = factor, query
    end

    def parent_indices
      @parent_indices ||= factor.properties.inject({}) {|hash, parent| hash[parent] = hash.size + 1; hash}
    end

    def unmatched_conditions
    end

    def normalize
    end

  end
end
