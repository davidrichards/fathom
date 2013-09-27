require File.expand_path('../action_object', __FILE__)

module Fathom
  class ConditionTable < ActionObject

    attr_reader :table, :query, :zero, :conditions

    def initialize(table, query, zero=0.0)
      @table = infer_table(table)
      @query = query
      @conditions = infer_conditions(query)
      @zero = zero
    end

    def execute!
      conditioned_table
    end

    def conditioned_table
      @conditioned_table ||= NormalizeTable.execute!(raw_table)
    end

    def raw_table
      @raw_table ||= table.inject({}) do |new_table, (table_key, table_value)|
        new_table[table_key] = matches?(table_key) ? table_value : zero
        new_table
      end
    end

    protected

    def infer_table(object)
      case object
      when Factor
        object.table
      else
        object
      end
    end

    def matches?(table_key)
      conditions.all? { |condition_key, condition_value| Array(condition_value).include?(table_key[condition_key]) }
    end

    def infer_conditions(query)
      case query
      when Hash
        query
      when Query
        query.conditions
      end
    end

  end
end
