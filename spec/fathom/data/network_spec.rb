require File.expand_path('../../../spec_helper', __FILE__)

include Fathom

describe Network do
  it "should initialize with a name accessor" do
    n = Network.new :name => :name
    n.name.should eql(:name)
    n.name = :new_name
    n.name.should eql(:new_name)
  end
  
  it "should initialize with a nodes accessor" do
    n = Network.new :nodes => [1,2,3]
    n.nodes.should eql([1,2,3])
  end
  
  it "should extend Enumerable" do
    Network.ancestors.should be_include(Enumerable)
  end
  
  it "should enumerate over the nodes" do
    n = Network.new :nodes => [1,2,3]
    n.map.to_a.should eql([1,2,3])
  end
end