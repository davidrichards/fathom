=begin

  Build Factor Base
  =================

  The common methods for building factors.

=end

require File.expand_path('../action_object', __FILE__)
module Fathom

  class BuildFactorBase < ActionObject

    protected

    def parent_labels
      @parent_labels ||= variables.parents.keys
    end

    def parent_values
      @parent_values ||= variables.parents.values
    end

    def label
      @label ||= variables.label
    end

    def values
      @values ||= variables.values
    end

    def table_keys
      parent_values.inject(values) {|a, i| a.product(i)}.map(&:flatten)
    end

  end

end
