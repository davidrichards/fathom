=begin

  Build Graph
  ===========

  Data:

  * observations (CSV)
  * variable definitions
  * priors (hash with prior values in the same order as the variable definitions)
  * graph

  Graph Hash

  {
    priors: {...}
    factors: [...]
  }

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

    attr_reader :dependent_variables, :observations

    def initialize(dependent_variables, observations, opts={})
      @dependent_variables = dependent_variables
      @observations = observations
      @priors = opts[:priors]
    end

    def factors
      @factors ||= dependent_variables.map {|d| BuildDiscreteFactor.execute!(d, observations)}
    end

    def variables
      @variables ||= dependent_variables.inject({}) do |hash, variable|
        hash[variable.dependent_label] = variable
        variable.independents.each do |label, values|
          hash[label] ||= Variable.new(dependent_label: label, dependent_values: values)
        end
        hash
      end
    end

    def parents
      @parents ||= variables.select do |label, variable|
        not dependent_variables.map(&:dependent_label).include? label
      end
    end

    def priors
      @priors ||= {}
      parents.each do |label, parent|
        size = parent.dependent_values.size
        @priors[label] ||= Array.new(size, 1.0 / size)
      end
      @priors
    end

    def graph
      @graph ||= Graph.new({
        priors: priors,
        factors: factors
      })
    end
    alias_method :execute!, :graph

    def inspect
      @inspect ||= "BuildGraph (#{data.size}) #{header.inspect}"
    end

  end
end