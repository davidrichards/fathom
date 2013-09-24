require File.expand_path('../action_object', __FILE__)

module Fathom
  class MarginalizeTable < ActionObject

    attr_reader :table, :filter

    def initialize(table, filter)
      @table = table
      @filter = filter
    end

    def execute!
      conditioned_table
    end

    def conditioned_table
      @conditioned_table ||= NormalizeTable.execute!(raw_table)
    end

    def raw_table
      @raw_table ||= new_keys.inject({}) do |raw_table, table_key|
        raw_table[table_key] = extract(table_key)
        raw_table
      end
    end

    def new_keys
      @new_keys ||= table.keys.map do |key|
        key.inject({}) do |hash, (k, v)|
          hash[k] = v unless filter.include?(k)
          hash
        end
      end.uniq
    end

    protected

    def extract(query)
      table.inject(0.0) do |sum, (table_key, table_value)|
        sum += table_value if matches?(table_key, query)
        sum
      end
    end

    def matches?(table_key, query)
      query.all? { |query_key, query_value| Array(query_value).include?(table_key[query_key]) }
    end

  end
end
