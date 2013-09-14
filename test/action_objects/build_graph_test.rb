require 'test_helper'
require 'build_graph'
require 'build_discrete_factor'

include Fathom
describe BuildGraph do

  let(:dependent_variables) do
    [Variable.new({
      dependent_label: 'a',
      dependent_values: [1, 0],
      independents: {
        'b' => [1,0]
      }
    })]
  end
  let(:observations) { get_observations }
  subject { Fathom::BuildGraph.new(dependent_variables, observations) }

  it "knows how to execute! at a class level" do
    assert BuildGraph.respond_to?(:execute!)
  end

  it "takes dependent_variables and observations" do
    assert_equal dependent_variables, subject.dependent_variables
    assert_equal observations, subject.observations
  end

  it "generates a factor from every variable definition" do
    factor = BuildDiscreteFactor.execute!(dependent_variables[0], observations)
    assert_equal factor, subject.factors[0]
  end

  it "extracts a variable list from the dependent variables and their independents" do
    assert_equal dependent_variables[0], subject.variables['a']
    assert subject.variables['b']
  end

  it "uses the dependent variables as the definitive source in the variables list" do
    dependent_variables << Variable.new(dependent_label: 'b', dependent_values: [1,0], independents: {c: [:panda, :bear]})
    subject = BuildGraph.new(dependent_variables, observations)
    variable_b = subject.variables['b']
    refute variable_b.independents.empty?
  end

  it "creates a list of parent variables" do
    variable_b = subject.parents['b']
    assert variable_b
    assert_equal [1,0], variable_b.dependent_values
  end

  it "takes an optional list of priors" do
    subject = Fathom::BuildGraph.new(dependent_variables, observations, priors: {'b' => [0.25, 0.75]})
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
