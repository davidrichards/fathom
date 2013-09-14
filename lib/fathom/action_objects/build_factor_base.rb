=begin

  Build Factor Base
  =================

  The common methods for building factors.

=end

require File.expand_path('../action_object', __FILE__)
module Fathom

  class BuildFactorBase < ActionObject

    protected

    def independent_labels
      @independent_labels ||= variables.independents.keys
    end

    def independent_values
      @independent_values ||= variables.independents.values
    end

    def dependent_label
      @dependent_label ||= variables.dependent_label
    end

    def dependent_values
      @dependent_values ||= variables.dependent_values
    end

    def table_keys
      independent_values.inject(dependent_values) {|a, i| a.product(i)}.map(&:flatten)
    end

  end

end
