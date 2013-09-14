require 'test_helper'

include Fathom

describe Variable do

  subject { Variable.new }

  it "takes a dependent_label as a string" do
    subject = Variable.new(dependent_label: :name)
    assert_equal 'name', subject.dependent_label
  end

  it "defaults dependent_values as an Array" do
    assert_equal [], subject.dependent_values
    subject = Variable.new(dependent_values: [1,0])
    assert_equal [1,0], subject.dependent_values
  end

  it "defaults the independents to {}" do
    assert_equal({}, subject.independents)
    subject = Variable.new(independents: {test: :this})
    assert_equal :this, subject.independents[:test]
  end

end
