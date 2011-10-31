require File.expand_path('../../../spec_helper', __FILE__)

include Fathom

describe AdjacencyMatrix do
  before do
    @am = AdjacencyMatrix.new
  end
  
  it "should use an efficient data storage method, a Hash that defaults to 0" do
    store = @am.send(:instance_variable_get, :@store)
    store.should be_a(Hash)
    store[:not_indexed].should eql(0)
  end
  
  it "should take an arbitrary default for the store" do
    am = AdjacencyMatrix.new(:arbitrary)
    store = am.send(:instance_variable_get, :@store)
    store[:not_indexed].should eql(:arbitrary)
  end
  
  it "should take a parent and child argument to get or set a value in the store" do
    lambda{@am[1]}.should raise_error(ArgumentError, /wrong number of arguments/)
    @am[1,1] = 1
    @am[1,1].should eql(1)
  end
  
  it "should be an Enumerable" do
    AdjacencyMatrix.included_modules.should be_include(Enumerable)
  end
  
  it "should enumerate on the store" do
    @am[1,1] = 1
    @am[2,1] = 1
    @am.map.to_a.should eql([[[1, 1], 1], [[2, 1], 1]])
    @am.each do |(parent, child), value|
      child.should eql(1)
      value.should eql(1)
      [1,2].should be_include(parent)
    end
  end
end