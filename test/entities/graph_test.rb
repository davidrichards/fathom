require 'test_helper'

include Fathom

describe Graph do

  subject { Graph.new }

  it "defaults the priors to a hash" do
    assert_equal({}, subject.priors)
    subject = Graph.new(priors: {'a' => [0.2, 0.8]})
    assert_equal [0.2, 0.8], subject.priors['a']
  end

  it "can take an adjacency list" do
    assert_equal [], subject.adjacency_list
    subject = Graph.new(adjacency_list: [['a', 'b']])
    assert_equal [['a', 'b']], subject.adjacency_list
  end

  it "defaults the factors to an array of factors" do
    assert_equal [], subject.factors
    subject = Graph.new(factors: [{label: :panda}])
    assert_equal "panda", subject.factors[0].label
  end

  it "defaults the local_observations as a hash" do
    assert_equal({}, subject.local_observations)
    subject = Graph.new(local_observations: {'a' => 1})
    assert_equal 1, subject.local_observations['a']
  end
end
