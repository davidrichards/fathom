require 'test_helper'
require 'condition_table'

include Fathom
describe ConditionTable do

  let(:table) do
    {
      {'a' => 1, 'b' => 'x'} => 1,
      {'a' => 1, 'b' => 'y'} => 2,
      {'a' => 0, 'b' => 'x'} => 3,
      {'a' => 0, 'b' => 'y'} => 4
    }
  end
  let(:query) { Query.new(conditions: {'a' => 1}) }
  subject     { ConditionTable.new(table, query) }

  it "knows how to execute! at a class level" do
    assert ConditionTable.respond_to?(:execute!)
  end

  it "takes a table and query" do
    assert_equal table, subject.table
    assert_equal query, subject.query
  end

  it "defaults zero to 0.0" do
    assert_equal 0.0, subject.zero
  end

  it "can take another zero" do
    subject = ConditionTable.new(table, query, 1.0)
    assert_equal 1.0, subject.zero
  end

  it "infers the conditions" do
    assert_equal({"a"=>1}, subject.conditions)
  end

  it "can take a hash as a query" do
    subject = ConditionTable.new(table, "a" => 1)
    assert_equal({"a"=>1}, subject.conditions)
  end

  it "removes non-matching rows in the raw table" do
    expected = {
      {"a"=>1, "b"=>"x"}=>1, {"a"=>1, "b"=>"y"}=>2,
      {"a"=>0, "b"=>"x"}=>0.0, {"a"=>0, "b"=>"y"}=>0.0
    }
    assert_equal expected, subject.raw_table
  end

  it "normalizes the table" do
    expected = {
      {"a"=>1, "b"=>"x"}=>Rational(1,3), {"a"=>1, "b"=>"y"}=>Rational(2,3),
      {"a"=>0, "b"=>"x"}=>0.0, {"a"=>0, "b"=>"y"}=>0.0
    }
    assert_equal expected, subject.conditioned_table
  end

  it "returns the conditioned_table on execute" do
    assert_equal subject.conditioned_table, subject.execute!
  end

  it "can condition with OR values in the query" do
    subject = ConditionTable.new(table, "a" => [0,1])
    assert_equal table, subject.raw_table
    expected = {
      {"a"=>1, "b"=>"x"}=>0.1, {"a"=>1, "b"=>"y"}=>0.2,
      {"a"=>0, "b"=>"x"}=>0.3, {"a"=>0, "b"=>"y"}=>0.4
    }
    assert_equal expected, subject.conditioned_table
  end

end
