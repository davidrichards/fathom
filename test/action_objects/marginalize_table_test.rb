require 'test_helper'
require 'condition_table'

include Fathom
describe MarginalizeTable do

  let(:table) do
    {
      {'a' => 1, 'b' => 'x'} => 1,
      {'a' => 1, 'b' => 'y'} => 2,
      {'a' => 0, 'b' => 'x'} => 3,
      {'a' => 0, 'b' => 'y'} => 4
    }
  end
  let(:filter) { ['b'] }
  subject     { MarginalizeTable.new(table, filter) }

  it "knows how to execute! at a class level" do
    assert MarginalizeTable.respond_to?(:execute!)
  end

  it "takes a table and filter" do
    assert_equal table, subject.table
    assert_equal filter, subject.filter
  end

  it "can take a Factor instead of a table" do
    variable_a = Variable.new(label: 'a', domain: [1,0])
    variable_b = Variable.new(label: 'b', domain: [1,0], parents: ['a'])
    factor = BuildDiscreteUniformFactor.execute!(variable_a, variable_b)
    subject = MarginalizeTable.new(factor, filter)
    table = subject.execute!
    expected = {{"a"=>1}=>Rational(1,2), {"a"=>0}=>Rational(1,2)}
    assert_equal expected, table
  end

  it "creates a set of new keys, based on filtering out filter" do
    expected = [{"a"=>1}, {"a"=>0}]
    assert_equal expected, subject.new_keys
  end

  it "creates a raw table, based on summing matches to the new keys" do
    expected = {{"a"=>1}=>3.0, {"a"=>0}=>7.0}
    assert_equal expected, subject.raw_table
  end

  it "normalizes the raw table in the conditioned_table" do
    expected = {{"a"=>1}=>0.3, {"a"=>0}=>0.7}
    assert_equal expected, subject.conditioned_table
  end

  it "returns the conditioned_table on execute" do
    assert_equal subject.conditioned_table, subject.execute!
  end

end
