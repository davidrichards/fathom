require 'test_helper'

include Fathom

describe Variable do

  subject { Variable.new }

  it "takes a label as a string" do
    subject = Variable.new(label: :name)
    assert_equal 'name', subject.label
  end

  it "defaults domain as an Array" do
    assert_equal [], subject.domain
    subject = Variable.new(domain: [1,0])
    assert_equal [1,0], subject.domain
  end

  it "defaults the parents to {}" do
    assert_equal({}, subject.parents)
    subject = Variable.new(parents: {test: :this})
    assert_equal :this, subject.parents[:test]
  end

end
