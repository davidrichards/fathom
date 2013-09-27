=begin

  Build Graph
  ===========

  Data:

  * observations (CSV)
  * variable definitions
  * priors (hash with prior values in the same order as the variable definitions)
  * graph

  Primary Course:

  User provides variable definitions and observations
  System updates the frequencies from observations
  System replaces zeroes with the default probability (1 / 3 orders of magnitude greater than the observation size)
  System normalizes the frequency table into a probability table
  System returns a factor

=end

require File.expand_path('../action_object', __FILE__)

module Fathom
  class BuildGraph < ActionObject

    attr_reader :variables, :observations, :priors

    def initialize(variables, observations, opts={})
      @variables    = variables
      @observations = observations
      @priors       = infer_priors(opts.fetch(:priors, {}))
    end

    def variable_labels
      @variable_labels ||= variables.map(&:label)
    end

    def dependent_variable_labels
      @dependent_variable_labels ||= adjacency_list.map {|array| array[1]}.uniq
    end

    def independent_variable_labels
      @independent_variable_labels ||= variable_labels - dependent_variable_labels
    end

    def independent_variables
      @independent_variables ||= variables.select { |variable| independent_variable_labels.include?(variable.label) }
    end

    def dependent_variables
      @dependent_variables ||= variables - independent_variables
    end

    def adjacency_list
      @adjacency_list ||= variables.inject([]) do |array, variable|
        child_label = variable.label
        variable.parents.each do |parent_label|
          array << [parent_label, child_label]
        end
        array
      end.uniq
    end

    # FIXME: Make this a type of Factor that works interchangeably with other factors.
    def infer_priors(priors)
      independent_variables.each do |variable|
        size = variable.domain.size
        priors[variable.label] ||= Array.new(size, Rational(1, size))
      end
      priors
    end

    def factors
      @factors ||= dependent_variables.map do |variable|
        parents = variables.select { |parent| variable.parents.include?(parent.label) }
        BuildDiscreteFactor.execute!([variable] + parents, parents.map(&:label), observations)
      end
    end

    def graph
      @graph ||= Graph.new({
        priors:         priors,
        factors:        factors,
        adjacency_list: adjacency_list
      })
    end
    alias_method :execute!, :graph

    def inspect
      @inspect ||= "BuildGraph (#{data.size}) #{header.inspect}"
    end

  end
end