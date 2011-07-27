require File.expand_path('../../../spec_helper', __FILE__)

include Fathom

describe Edge do
  
  it "should initialize a is_directed accessor" do
    Edge.should have_an_initialization_accessor_for(:is_directed)
  end
  
  it "should default the edge to true" do
    edge = Edge.new
    edge.is_directed.should be_true
  end
end