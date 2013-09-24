=begin

  Build Factor Base
  =================

  The common methods for building factors.

=end

require File.expand_path('../action_object', __FILE__)
module Fathom

  class BuildFactorBase < ActionObject

    def table_keys
      @table_keys ||= domain_product.inject([]) { |table_keys, array| table_keys << hash_from_ordered_values(array) }
    end

    protected

    def parent_variables
      @parent_variables ||= variables.select {|variable| parent_labels.include?(variable.label)}
    end

    def parent_domains
      @parent_domains ||= parent_variables.map(&:domain)
    end

    def variable_labels
      @variable_labels ||= variables.map(&:label)
    end

    def target_label
      @target_label ||= (variable_labels - parent_labels).first
    end
    alias_method :label, :target_label

    def target
      @target ||= variables.select {|variable| variable.label == target_label }.first
    end

    def domain
      @domain ||= target.domain
    end

    def domain_product
      @domain_product ||= domain.product(*parent_domains)
    end

    # Order is target, parents, generated in domain_product
    def hash_from_ordered_values(array)
      key = {target_label => array[0]}
      array[1..-1].each_with_index do |e, i|
        key[parent_labels[i]] = e
      end
      key
    end

  end
end
