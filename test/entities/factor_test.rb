require 'test_helper'

include Fathom

describe Factor do

  subject { Factor.new }

  it "takes a name as a string" do
    subject = Factor.new(name: :name)
    assert_equal 'name', subject.name
  end

  it "defaults properties to {}" do
    assert_equal({}, subject.properties)
    subject = Factor.new(properties: {test: :this})
    assert_equal :this, subject.properties[:test]
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
    subject = Factor.new(table: {test: :this})
    assert_equal :this, subject.table[:test]
  end

end
