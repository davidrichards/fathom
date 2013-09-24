require 'test_helper'
require 'build_discrete_factor'

include Fathom
describe BuildDiscreteFactor do

  let(:variables) do
    [
      Variable.new(label: 'a', domain: [1,0]),
      Variable.new(label: 'b', domain: %w(x y), parents: ['a'])
    ]
  end
  let(:observations)  { get_observations('a_to_d.csv') }
  let(:parent_labels) { %w(a c) }
  subject { Fathom::BuildDiscreteFactor.new(variables, parent_labels, observations) }

  it "takes variables, parent_labels and observations" do
    assert_equal variables, subject.variables
    assert_equal parent_labels, subject.parent_labels
    assert_equal observations, subject.observations
  end

  it "knows how to execute! at a class level" do
    assert BuildDiscreteFactor.respond_to?(:execute!)
  end

  describe "table_keys" do
    it "builds all possible row values in table_keys" do
      expected = [
        {"b" => "x", "a" => 1},
        {"b" => "x", "a" => 0},
        {"b" => "y", "a" => 1},
        {"b" => "y", "a" => 0},
      ]
      keys = subject.table_keys
      assert_equal expected, keys
    end

    it "works well with variables with larger domains" do
      variables = [
        Variable.new(label: 'a', domain: [1,2,3]),
        Variable.new(label: 'b', domain: %w(x y z), parents: ['a'])
      ]
      subject = Fathom::BuildDiscreteFactor.new(variables, parent_labels, observations)
      expected = [
        {"b" => "x", "a" => 1},
        {"b" => "x", "a" => 2},
        {"b" => "x", "a" => 3},
        {"b" => "y", "a" => 1},
        {"b" => "y", "a" => 2},
        {"b" => "y", "a" => 3},
        {"b" => "z", "a" => 1},
        {"b" => "z", "a" => 2},
        {"b" => "z", "a" => 3}
      ]
      keys = subject.table_keys
      assert_equal expected, keys
    end

    it "works well with multiple parents" do
      variables = [
        Variable.new(label: 'b', domain: %w(x y)),
        Variable.new(label: 'c', domain: [1,0]),
        Variable.new(label: 'd', domain: %w(yes no), parents: %w(b c))
      ]
      parent_labels = %w(b c)
      subject = Fathom::BuildDiscreteFactor.new(variables, parent_labels, observations)
      expected = [
        {"d"=>"yes", "b"=>"x", "c"=>1},
        {"d"=>"yes", "b"=>"x", "c"=>0},
        {"d"=>"yes", "b"=>"y", "c"=>1},
        {"d"=>"yes", "b"=>"y", "c"=>0},
        {"d"=>"no", "b"=>"x", "c"=>1},
        {"d"=>"no", "b"=>"x", "c"=>0},
        {"d"=>"no", "b"=>"y", "c"=>1},
        {"d"=>"no", "b"=>"y", "c"=>0}
      ]
      keys = subject.table_keys
      assert_equal expected, keys
    end
  end

  describe "frequencies" do
    it "counts the frequency of the observations" do
      assert_equal 10, subject.frequency_table[{"b" => "x", "a" => 1}]
      assert_equal 48, subject.frequency_table[{"b" => "x", "a" => 0}]
      assert_equal 31, subject.frequency_table[{"b" => "y", "a" => 1}]
      assert_equal 71, subject.frequency_table[{"b" => "y", "a" => 0}]
    end

    it "works well with variables with larger domains" do
      variables = [
        Variable.new(label: 'a', domain: [1,2,3]),
        Variable.new(label: 'b', domain: %w(x y z), parents: ['a'])
      ]
      subject = Fathom::BuildDiscreteFactor.new(variables, parent_labels, observations)

      assert_equal 48, subject.frequency_table[{"b" => "x", "a" => 0}]
      assert_equal 10, subject.frequency_table[{"b" => "x", "a" => 1}]
      assert_equal 0,  subject.frequency_table[{"b" => "x", "a" => 2}]
      assert_equal 0,  subject.frequency_table[{"b" => "x", "a" => 3}]
      assert_equal 71, subject.frequency_table[{"b" => "y", "a" => 0}]
      assert_equal 31, subject.frequency_table[{"b" => "y", "a" => 1}]
      assert_equal 0,  subject.frequency_table[{"b" => "y", "a" => 2}]
      assert_equal 0,  subject.frequency_table[{"b" => "y", "a" => 3}]
      assert_equal 0,  subject.frequency_table[{"b" => "z", "a" => 0}]
      assert_equal 0,  subject.frequency_table[{"b" => "z", "a" => 1}]
      assert_equal 0,  subject.frequency_table[{"b" => "z", "a" => 2}]
      assert_equal 0,  subject.frequency_table[{"b" => "z", "a" => 3}]
    end

    it "works well with multiple parents" do
      variables = [
        Variable.new(label: 'b', domain: %w(x y)),
        Variable.new(label: 'c', domain: [1,0]),
        Variable.new(label: 'd', domain: %w(yes no), parents: %w(b c))
      ]
      parent_labels = %w(b c)
      subject = Fathom::BuildDiscreteFactor.new(variables, parent_labels, observations)

      assert_equal 15, subject.frequency_table[{"d"=>"yes", "b"=>"x", "c"=>1}]
      assert_equal 18, subject.frequency_table[{"d"=>"yes", "b"=>"x", "c"=>0}]
      assert_equal 15, subject.frequency_table[{"d"=>"yes", "b"=>"y", "c"=>1}]
      assert_equal 30, subject.frequency_table[{"d"=>"yes", "b"=>"y", "c"=>0}]
      assert_equal 14, subject.frequency_table[{"d"=>"no", "b"=>"x", "c"=>1}]
      assert_equal 11, subject.frequency_table[{"d"=>"no", "b"=>"x", "c"=>0}]
      assert_equal 23, subject.frequency_table[{"d"=>"no", "b"=>"y", "c"=>1}]
      assert_equal 34, subject.frequency_table[{"d"=>"no", "b"=>"y", "c"=>0}]
    end
  end

  describe "probability_table" do

    it "provides the probabilities" do
      assert_equal 0.0625, subject.probability_table[{"b" => "x", "a" => 1}]
      assert_equal 0.3, subject.probability_table[{"b" => "x", "a" => 0}]
      assert_equal 0.19375, subject.probability_table[{"b" => "y", "a" => 1}]
      assert_equal 0.44375, subject.probability_table[{"b" => "y", "a" => 0}]
    end

    it "provides probabilities for unobserved values" do
      variables = [
        Variable.new(label: 'a', domain: [1,2,3]),
        Variable.new(label: 'b', domain: %w(x y z), parents: ['a'])
      ]
      subject = Fathom::BuildDiscreteFactor.new(variables, parent_labels, observations)
      keys = subject.probability_table.keys
      assert_in_delta 0.0000625, subject.probability_table[{"b" => "x", "a" => 2}], 0.001
    end

    it "creates a normalized probability" do
      sum = subject.probability_table.inject(0.0) { |s, (k, v)| s + v }
      assert_in_delta 1.0, sum, 1.0e-25
    end

  end

  it "returns a factor" do
    factor = subject.factor
    assert_equal 'b', factor.label
    assert_equal variables[1], factor.target
    assert_equal ['a', 'c'], factor.parents
    assert_equal subject.probability_table, factor.table
  end

  it "uses execute! to produce the factor" do
    assert_equal subject.factor, subject.execute!
  end

end
