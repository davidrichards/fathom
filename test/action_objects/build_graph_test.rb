require 'test_helper'
require 'build_graph'
require 'build_discrete_factor'

include Fathom
describe BuildGraph do

  let(:variable_a)        { Variable.new(label: 'a', domain: [1, 0], parents: ['b']) }
  let(:variable_b)        { Variable.new(label: 'b', domain: %w(x y)) }
  let(:variable_c)        { Variable.new(label: 'c', domain: [1,0]) }
  let(:variable_d)        { Variable.new(label: 'd', domain: %w(yes no), parents: %w(b c)) }
  let(:variables)         { [variable_a, variable_b] }
  let(:observations)      { get_observations }
  let(:complex_variables) { [variable_a, variable_b, variable_c, variable_d] }
  let(:complex_subject)   { Fathom::BuildGraph.new(complex_variables, get_observations('a_to_d.csv'))}
  subject                 { Fathom::BuildGraph.new(variables, observations) }

  it "knows how to execute! at a class level" do
    assert BuildGraph.respond_to?(:execute!)
  end

  it "takes variables" do
    assert_equal variables, subject.variables
  end

  it "takes observations" do
    assert_equal observations, subject.observations
  end

  it "extracts the variable labels" do
    assert_equal %w(a b), subject.variable_labels
  end

  it "extracts the dependent variable labels" do
    assert_equal [variable_a.label], subject.dependent_variable_labels
  end

  it "extracts the dependent variable labels from a complex graph" do
    assert_equal [variable_a.label, variable_d.label], complex_subject.dependent_variable_labels
  end

  it "extracts the independent variable labels" do
    assert_equal [variable_b.label], subject.independent_variable_labels
  end

  it "extracts the independent variable labels from a complex graph" do
    assert_equal [variable_b.label, variable_c.label], complex_subject.independent_variable_labels
  end

  it "extracts the dependent variables" do
    assert_equal [variable_a], subject.dependent_variables
  end

  it "extracts the dependent variables from a complex graph" do
    assert_equal [variable_a, variable_d], complex_subject.dependent_variables
  end

  it "extracts the independent variables" do
    assert_equal [variable_b], subject.independent_variables
  end

  it "extracts the independent variables from a complex graph" do
    assert_equal [variable_b, variable_c], complex_subject.independent_variables
  end

  it "builds an adjacency list" do
    assert_equal [['b', 'a']], subject.adjacency_list
  end

  it "builds an adjacency list from a complex graph" do
    assert_equal [["b", "a"], ["b", "d"], ["c", "d"]], complex_subject.adjacency_list
  end

  it "infers priors for any independent variables" do
    expected = [Factor.new(label: 'b', table: {{'b' => 'x'} => Rational(1,2), {'b' => 'y'} => Rational(1,2)})]
    assert_equal expected, subject.priors
  end

  it "can take pre-calculated priors as an initialization option" do
    subject = Fathom::BuildGraph.new(variables, observations, priors: {'b' => [Rational(1,10), Rational(9,10)]})
    prior = subject.priors[0]
    assert_equal 'b', prior.label
    assert_equal Rational(1,10), prior.table["b" => "x"]
    assert_equal Rational(9,10), prior.table["b" => "y"]
  end

  it "can take some of the priors as pre-calculated values" do
    complex_subject = Fathom::BuildGraph.new(complex_variables, observations, priors: {'b' => [Rational(1,10), Rational(9,10)]})

    prior_b = complex_subject.priors[0]
    assert_equal 'b', prior_b.label
    assert_equal Rational(1,10), prior_b.table["b" => "x"]
    assert_equal Rational(9,10), prior_b.table["b" => "y"]

    prior_c = complex_subject.priors[1]
    assert_equal 'c', prior_c.label
    assert_equal Rational(1,2), prior_c.table["c" => 1]
    assert_equal Rational(1,2), prior_c.table["c" => 0]
  end

  it "supplies the priors as the first factors" do
    prior = subject.factors[0]
    assert_equal 'b', prior.label
    assert_equal Rational(1,2), prior.table["b" => "x"]
    assert_equal Rational(1,2), prior.table["b" => "y"]
  end

  it "generates more-complex factors for the dependent variables" do
    factor = subject.factors[1]
    assert_equal 'a', factor.label
    assert_in_delta 0.0000099, factor.table["b" => "x", "a" => 1], 0.0000001
    assert_in_delta 0.399984, factor.table["a"=>0, "b"=>0], 0.0000001
  end


  it "builds factors for the dependent variables, based on the observations from a complex graph" do

    assert_equal 4, complex_subject.factors.size

    factor = complex_subject.factors[0]

    assert_equal 'b', factor.label
    assert_equal [], factor.parents
    assert_equal 'discrete', factor.type
    expected_table = {
      {"b"=>"x"}=>Rational(1,2), {"b"=>"y"}=>Rational(1,2)
    }
    assert_equal(expected_table, factor.table)

    factor = complex_subject.factors[-1]

    assert_equal 'd', factor.label
    assert_equal variable_d, factor.target
    assert_equal ['b', 'c'], factor.parents
    assert_equal 'discrete', factor.type
    expected_table = {
      {"d"=>"yes", "b"=>"x", "c"=>1}=>0.09375, {"d"=>"yes", "b"=>"x", "c"=>0}=>0.1125,
      {"d"=>"yes", "b"=>"y", "c"=>1}=>0.09375, {"d"=>"yes", "b"=>"y", "c"=>0}=>0.1875,
      {"d"=>"no", "b"=>"x", "c"=>1}=>0.0875, {"d"=>"no", "b"=>"x", "c"=>0}=>0.06875,
      {"d"=>"no", "b"=>"y", "c"=>1}=>0.14375, {"d"=>"no", "b"=>"y", "c"=>0}=>0.2125
    }
    assert_equal(expected_table, factor.table)
  end

  it "builds a graph from factors, the adjacency list and priors" do
    assert_equal subject.priors, subject.graph.priors
    assert_equal subject.adjacency_list, subject.graph.adjacency_list
    assert_equal subject.factors, subject.graph.factors
  end

  it "provides the graph on execute!" do
    assert_equal subject.graph, subject.execute!
  end

end
