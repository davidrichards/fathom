require File.expand_path('../../../spec_helper', __FILE__)

include Fathom

describe Edge do
  it "should initialize with is_directed" do
    edge = Edge.new(:is_directed => false)
    edge.is_directed.should be_false
  end
  
  it "should default the edge to true" do
    edge = Edge.new
    edge.is_directed.should be_true
  end
end