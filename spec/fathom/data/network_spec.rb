require File.expand_path('../../../spec_helper', __FILE__)

include Fathom

describe Network do
  
  it "should initialize a name accessor" do
    Network.should have_an_initialization_accessor_for(:name)
  end
  
  it "should initialize a variables accessor" do
    Network.should have_an_initialization_accessor_for(:variables)
  end
  
  it "should extend Enumerable" do
    Network.ancestors.should be_include(Enumerable)
  end
  
  it "should enumerate over the variables" do
    n = Network.new :variables => [1,2,3]
    n.map.to_a.should eql([1,2,3])
  end

  it "should initialize a properties accessor" do
    Network.should have_an_initialization_accessor_for(:properties)
  end

  it "should initialize a edges accessor" do
    Network.should have_an_initialization_accessor_for(:edges)
  end
  
  it "should initialize a definitions accessor" do
    Network.should have_an_initialization_accessor_for(:definitions)
  end
  
end

