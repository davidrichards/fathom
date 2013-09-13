require 'test_helper'
require 'build_graph'
require 'build_discrete_factor'

include Fathom
describe BuildGraph do

  let(:variable_definitions) do
    [{
      dependent_label: 'a',
      dependent_values: [1, 0],
      independents: {
        'b' => [1,0]
      }
    }]
  end
  let(:observations) { get_observations }
  subject { Fathom::BuildGraph.new(variable_definitions, observations) }


  it "knows how to execute! at a class level" do
    assert BuildGraph.respond_to?(:execute!)
  end

  it "takes variable_definitions and observations" do
    assert_equal variable_definitions, subject.variable_definitions
    assert_equal observations, subject.observations
  end

  it "generates a factor from every variable definition" do
    factor = BuildDiscreteFactor.execute!(variable_definitions[0], observations)
    assert_equal factor, subject.factors[0]
  end

  it "extracts a variable list from the variable definitions" do
    assert_equal [1,0], subject.variables['a']
    assert_equal [1,0], subject.variables['b']
  end

  it "creates a list of dependent variables" do
    assert_equal({'a' => [1,0]}, subject.dependent_variables)
  end

  it "creates a list of parent variables" do
    assert_equal({'b' => [1,0]}, subject.parents)
  end

  it "takes an optional list of priors" do
    subject = Fathom::BuildGraph.new(variable_definitions, observations, priors: {'b' => [0.25, 0.75]})
    assert_equal [0.25, 0.75], subject.priors['b']
  end

  it "defaults the priors to a uniform prior" do
    assert_equal [0.5, 0.5], subject.priors['b']
  end

  it "builds a graph from factors and priors" do
    assert_equal subject.priors, subject.graph[:priors]
    assert_equal({'b' => [0.5, 0.5]}, subject.graph[:priors])
    assert_equal subject.factors, subject.graph[:factors]
  end

  it "provides the graph on execute!" do
    assert_equal subject.graph, subject.execute!
  end

end
