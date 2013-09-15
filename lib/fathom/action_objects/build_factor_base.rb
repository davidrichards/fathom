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

    def parent_domains
      @parent_domains ||= variables.parents.values
    end

    def label
      @label ||= variables.label
    end

    def domain
      @domain ||= variables.domain
    end

    def table_keys
      parent_domains.inject(domain) {|a, i| a.product(i)}.map(&:flatten)
    end

  end

end
