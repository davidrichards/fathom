require 'test_helper'

include Fathom

describe Graph do

  subject { Graph.new }

  it "defaults the priors to a hash" do
    assert_equal({}, subject.priors)
    subject = Graph.new(priors: {'a' => [0.2, 0.8]})
    assert_equal [0.2, 0.8], subject.priors['a']
  end

  it "defaults the factors to an array" do
    assert_equal [], subject.factors
    subject = Graph.new(factors: [:panda, :bear])
    assert_equal :panda, subject.factors[0]
  end

end
