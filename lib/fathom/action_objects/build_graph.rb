=begin

  Build Graph
  ===========

  Data:

  * observations (CSV)
  * variable definitions
  * priors (hash with prior values in the same order as the variable definitions)
  * graph

  Variable Definitions
  [{
    dependent_label: label
    dependent_values: [values]
    independents: {
      label => [values]
      ...
    }
  }...]

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

    attr_reader :variable_definitions, :observations

    def initialize(variable_definitions, observations, opts={})
      @variable_definitions = variable_definitions
      @observations = observations
      @priors = opts[:priors]
    end

    def factors
      @factors ||= variable_definitions.map {|d| BuildDiscreteFactor.execute!(d, observations)}
    end

    def variables
      return @variables if @variables
      @variables = {}
      variable_definitions.each do |definition|
        @variables[definition[:dependent_label]] = definition[:dependent_values]
        definition[:independents].each do |label, values|
          @variables[label] = values
        end
      end
      @variables
    end

    def dependent_variables
      @dependent_variables ||= variable_definitions.inject({}) do |hash, definition|
        hash[definition[:dependent_label]] = definition[:dependent_values]
        hash
      end
    end

    def parents
      @parents ||= variables.select do |label, values|
        not dependent_variables.include?(label)
      end
    end

    def priors
      @priors ||= {}
      parents.each do |label, values|
        @priors[label] ||= Array.new(values.size, 1.0 / values.size)
      end
      @priors
    end

    def graph
      @graph ||= {
        priors: priors,
        factors: factors
      }
    end
    alias_method :execute!, :graph

    def inspect
      @inspect ||= "BuildGraph (#{data.size}) #{header.inspect}"
    end

  end
end