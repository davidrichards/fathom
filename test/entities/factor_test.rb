require 'test_helper'

include Fathom

describe Factor do

  subject { Factor.new }

  it "takes a label as a string" do
    subject = Factor.new(label: :label)
    assert_equal 'label', subject.label
  end

  it "takes a target" do
    variable = Variable.new(label: :a)
    subject = Factor.new(target: variable.attributes)
    assert_equal variable, subject.target
  end

  it "defaults parents to an array" do
    assert_equal [], subject.parents
  end

  it "defaults type to discrete" do
    assert_equal 'discrete', subject.type
  end

  it "type casts type to a string" do
    subject = Factor.new(type: :foo)
    assert_equal 'foo', subject.type
  end

  it "defaults the table to {}" do
    assert_equal({}, subject.table)
    subject = Factor.new(table: {{a: 1} => 1})
    assert_equal 1, subject.table[{a: 1}]
  end

end
