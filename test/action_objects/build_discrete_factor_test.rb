require 'test_helper'
require 'build_discrete_factor'

include Fathom
describe BuildDiscreteFactor do

  let(:variable_definitions) do
    {
      dependent_label: 'a',
      dependent_values: [1, 0],
      independents: {
        'b' => [1,0]
      }
    }
  end
  let(:observations) { get_observations }
  subject { Fathom::BuildDiscreteFactor.new(variable_definitions, observations) }

  it "knows how to execute! at a class level" do
    assert BuildDiscreteFactor.respond_to?(:execute!)
  end

  it "takes variable_definitions and observations" do
    assert_equal variable_definitions, subject.variable_definitions
    assert_equal observations, subject.observations
  end

  it "counts the frequency of the observations" do
    assert_equal 1, subject.frequency_table[[1,1]]
    assert_equal 2, subject.frequency_table[[1,0]]
    assert_equal 3, subject.frequency_table[[0,1]]
    assert_equal 4, subject.frequency_table[[0,0]]
  end

  it "provides the probabilities" do
    assert_equal 0.1, subject.probability_table[[1,1]]
    assert_equal 0.2, subject.probability_table[[1,0]]
    assert_equal 0.3, subject.probability_table[[0,1]]
    assert_equal 0.4, subject.probability_table[[0,0]]
  end

  it "returns a factor" do
    factor = subject.factor
    assert_equal 'a', factor[:name]
    assert_equal 'a', factor.name
    assert_equal ['b'], factor[:properties]
    assert_equal ['b'], factor.properties
    assert_equal subject.probability_table, factor[:table]
    assert_equal subject.probability_table, factor.table
  end

  it "uses execute! to produce the factor" do
    assert_equal subject.factor, subject.execute!
  end

  describe "normalized probabilities" do
    let(:observations) { get_observations('sparse.csv') }

    it "normalizes with very small numbers for unobserved possibilities" do
      assert_in_delta 0.00001, subject.probability_table[[0,0]], 0.00001
    end

    it "creates a factor near 1.0" do
      sum = subject.probability_table.inject(0.0) { |s, (k, v)| s + v }
      assert_in_delta 1.0, sum, 0.000000001
    end

    it "creates a normalized probability" do
      assert_in_delta 0.5, subject.probability_table[[0,1]], 0.00001
    end
  end
end
