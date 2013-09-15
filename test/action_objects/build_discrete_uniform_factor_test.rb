require 'test_helper'
require 'build_discrete_uniform_factor'

include Fathom
describe BuildDiscreteUniformFactor do

  let(:variables) do
    Variable.new(label: 'a', domain: [1,0], parents: {'b' => [1,0]})
  end
  subject { Fathom::BuildDiscreteUniformFactor.new(variables) }

  it "knows how to execute! at a class level" do
    assert BuildDiscreteUniformFactor.respond_to?(:execute!)
  end

  it "takes variables" do
    assert_equal variables, subject.variables
  end

  it "provides the probabilities" do
    assert_equal 0.25, subject.probability_table[[1,1]]
    assert_equal 0.25, subject.probability_table[[1,0]]
    assert_equal 0.25, subject.probability_table[[0,1]]
    assert_equal 0.25, subject.probability_table[[0,0]]
  end

  it "returns a factor" do
    factor = subject.factor
    assert_equal 'a', factor[:label]
    assert_equal 'a', factor.label
    assert_equal ['b'], factor[:properties]
    assert_equal ['b'], factor.properties
    assert_equal subject.probability_table, factor[:table]
    assert_equal subject.probability_table, factor.table
  end

  it "uses execute! to produce the factor" do
    assert_equal subject.factor, subject.execute!
  end

end
