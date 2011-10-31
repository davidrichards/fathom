require File.expand_path('../../../spec_helper', __FILE__)

include Fathom

describe Network do
  
  it "should initialize a name accessor" do
    Network.should have_an_initialization_accessor_for(:name)
  end
  
  it "should initialize a variables accessor" do
    Network.should have_an_initialization_accessor_for(:variables)
  end
  
  it "should default the variables to an array" do
    Network.new.variables.should eql([])
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
  
  it "should default the properties to an Array" do
    Network.new.properties.should eql([])
  end

  it "should initialize an edges accessor" do
    Network.should have_an_initialization_accessor_for(:edges)
  end
  
  it "should default the edges to an Array" do
    Network.new.edges.should eql([])
  end
  
  it "should initialize a definitions accessor" do
    Network.should have_an_initialization_accessor_for(:definitions)
  end
  
  it "should default the definitions to an Array" do
    Network.new.definitions.should eql([])
  end
  
  context "when using the Enumerator" do
    before do
      @n = Network.new :variables => [1,2,3]
      @variables = @n.variables 
    end
    
    it "should be able to iterate on the variables" do
      @n.each {|v| @variables.should be_include(v)}
    end
  
    it "should have each_variable as an alias to each" do
      @n.each_variable {|v| @variables.should be_include(v)}
    end
  
    it "should use the variable enumeration for the Enumerable" do
      @n.map {|v| v }.should eql([1,2,3])
    end
  end
  
end

