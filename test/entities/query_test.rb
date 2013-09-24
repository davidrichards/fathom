require 'test_helper'

include Fathom

describe Query do

  subject { Query.new }

  it "should default the target to a hash" do
    assert_equal({}, subject.target)
    subject.target = {label: :value}
    assert_equal({label: :value}, subject.target)
  end

  it "should default conditions to a hash" do
    assert_equal({}, subject.conditions)
    subject = Query.new(conditions: {panda: :bear})
    assert_equal :bear, subject.conditions[:panda]
  end

end
