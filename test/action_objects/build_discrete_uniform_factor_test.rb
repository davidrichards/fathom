require 'test_helper'
require 'build_discrete_uniform_factor'

include Fathom
describe BuildDiscreteUniformFactor do

  let(:target_variable) { Variable.new(label: 'a', domain: [1,0], parents: ['b']) }
  let(:parent_variable) { Variable.new(label: 'b', domain: [1,0]) }
  subject { Fathom::BuildDiscreteUniformFactor.new(target_variable, parent_variable) }


  it "knows how to execute! at a class level" do
    assert BuildDiscreteUniformFactor.respond_to?(:execute!)
  end

  it "takes a target_variable" do
    assert_equal target_variable, subject.target_variable
  end

  it "aliases target to target_variable" do
    assert_equal target_variable, subject.target
  end

  it "extracts the target_label" do
    assert_equal 'a', subject.target_label
  end

  it "aliases label to target_label" do
    assert_equal 'a', subject.label
  end

  it "takes parent_variables" do
    assert_equal [parent_variable], subject.parent_variables
  end

  it "extracts the parent_labels" do
    assert_equal ['b'], subject.parent_labels
  end

  describe "probability_table" do
    it "provides the probabilities" do
      assert_equal 0.25, subject.probability_table[{"a"=>1, "b"=>1}]
      assert_equal 0.25, subject.probability_table[{"a"=>1, "b"=>0}]
      assert_equal 0.25, subject.probability_table[{"a"=>0, "b"=>1}]
      assert_equal 0.25, subject.probability_table[{"a"=>0, "b"=>0}]
    end

    it "works well with variables with larger domains" do
      target_variable = Variable.new(label: 'a', domain: [1,2,3], parents: ['b'])
      subject = Fathom::BuildDiscreteUniformFactor.new(target_variable, parent_variable)
      expected = Rational(1,6)

      assert_in_delta expected, subject.probability_table[{"a"=>1, "b"=>1}], 0.0000001
      assert_in_delta expected, subject.probability_table[{"a"=>1, "b"=>0}], 0.0000001
      assert_in_delta expected, subject.probability_table[{"a"=>2, "b"=>1}], 0.0000001
      assert_in_delta expected, subject.probability_table[{"a"=>2, "b"=>0}], 0.0000001
      assert_in_delta expected, subject.probability_table[{"a"=>3, "b"=>1}], 0.0000001
      assert_in_delta expected, subject.probability_table[{"a"=>3, "b"=>0}], 0.0000001
    end

    it "works well with multiple parents" do
      target_variable = Variable.new(label: 'a', domain: [0,1], parents: ['b'])
      parent_variables = [
        Variable.new(label: 'b', domain: %w(x y)),
        Variable.new(label: 'c', domain: [1,0]),
        Variable.new(label: 'd', domain: %w(yes no), parents: %w(b c))
      ]
      subject = Fathom::BuildDiscreteUniformFactor.new(target_variable, parent_variables)
      expected = Rational(1,16)

      assert_in_delta expected, subject.probability_table[{"a"=>0, "b"=>"x", "c"=>1, "d"=>"yes"}], 0.0000001
      assert_in_delta expected, subject.probability_table[{"a"=>0, "b"=>"x", "c"=>1, "d"=>"no"}], 0.0000001
      assert_in_delta expected, subject.probability_table[{"a"=>0, "b"=>"x", "c"=>0, "d"=>"yes"}], 0.0000001
      assert_in_delta expected, subject.probability_table[{"a"=>0, "b"=>"x", "c"=>0, "d"=>"no"}], 0.0000001
      assert_in_delta expected, subject.probability_table[{"a"=>0, "b"=>"y", "c"=>1, "d"=>"yes"}], 0.0000001
      assert_in_delta expected, subject.probability_table[{"a"=>0, "b"=>"y", "c"=>1, "d"=>"no"}], 0.0000001
      assert_in_delta expected, subject.probability_table[{"a"=>0, "b"=>"y", "c"=>0, "d"=>"yes"}], 0.0000001
      assert_in_delta expected, subject.probability_table[{"a"=>0, "b"=>"y", "c"=>0, "d"=>"no"}], 0.0000001
      assert_in_delta expected, subject.probability_table[{"a"=>1, "b"=>"x", "c"=>1, "d"=>"yes"}], 0.0000001
      assert_in_delta expected, subject.probability_table[{"a"=>1, "b"=>"x", "c"=>1, "d"=>"no"}], 0.0000001
      assert_in_delta expected, subject.probability_table[{"a"=>1, "b"=>"x", "c"=>0, "d"=>"yes"}], 0.0000001
      assert_in_delta expected, subject.probability_table[{"a"=>1, "b"=>"x", "c"=>0, "d"=>"no"}], 0.0000001
      assert_in_delta expected, subject.probability_table[{"a"=>1, "b"=>"y", "c"=>1, "d"=>"yes"}], 0.0000001
      assert_in_delta expected, subject.probability_table[{"a"=>1, "b"=>"y", "c"=>1, "d"=>"no"}], 0.0000001
      assert_in_delta expected, subject.probability_table[{"a"=>1, "b"=>"y", "c"=>0, "d"=>"yes"}], 0.0000001
      assert_in_delta expected, subject.probability_table[{"a"=>1, "b"=>"y", "c"=>0, "d"=>"no"}], 0.0000001

    end
  end

  it "returns a factor" do
    factor = subject.factor
    assert_equal 'a', factor[:label]
    assert_equal 'a', factor.label
    assert_equal ['b'], factor[:parents]
    assert_equal ['b'], factor.parents
    assert_equal subject.probability_table, factor[:table]
    assert_equal subject.probability_table, factor.table
    assert_equal 'discrete', factor['type']
    assert_equal 'discrete', factor.type
  end

  it "uses execute! to produce the factor" do
    assert_equal subject.factor, subject.execute!
  end

end
