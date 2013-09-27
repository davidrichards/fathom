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
      @opts         = opts.with_indifferent_access
      @priors       = infer_priors
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

    def factors
      @factors ||= priors + dependent_variables.map do |variable|
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

    protected

    def infer_priors
      independent_variables.map { |variable| build_prior_factor(variable) }
    end

    def build_prior_factor(variable)
      Factor.new(label: variable.label, table: build_prior_table(variable))
    end

    def default_prior_table(variable)
      @opts.fetch(:priors, {}).inject({}) do |hash, (label, array)|
        array = Array(array)
        array.each_with_index do |prior_value, i|
          hash[{label => variable.domain[i]}] = prior_value
        end
        hash
      end
    end

    def build_prior_table(variable)
      size = variable.domain.size
      keys = variable.domain.inject(default_prior_table(variable)) do |hash, value|
        hash[{variable.label => value}] ||= Rational(1,size)
        hash
      end
    end
    public :build_prior_table

  end
end