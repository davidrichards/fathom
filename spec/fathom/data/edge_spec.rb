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
  
  it "should initialize a parent accessor" do
    edge = Edge.new(:parent => :value)
    edge.parent.should ==(Variable.new(:name => :value))
    edge.parent = :value2
    edge.parent.should ==(Variable.new(:name => :value2))
  end
  
  it "should initialize a child accessor" do
    edge = Edge.new(:child => :value)
    edge.child.should ==(Variable.new(:name => :value))
    edge.child = :value2
    edge.child.should ==(Variable.new(:name => :value2))
  end
  
  it "should be equal by variables" do
    v1 = Variable.new(:name => :v1)
    v2 = Variable.new(:name => :v2)
    e1 = Edge.new(:parent => v1, :child => v2)
    e2 = Edge.new(:parent => v1, :child => v2)
    e1.should ==(e2)
  end
  
  it "should ensure the parent and child are a variables" do
    edge = Edge.new :parent => :v1, :child => :v2
    edge.parent.should ==(Variable.new(:name => :v1))
    edge.child.should ==(Variable.new(:name => :v2))
  end
  
  context "when inferring an Edge" do
    it "should be able to infer an Edge from an Edge" do
      edge = Edge.new :parent => :v1, :child => :v2
      inferred = Edge.infer(edge)
      inferred.should eql(edge)
    end
    
    it "should be able to infer an Edge from an Array, [parent, child]" do
      v1 = Variable.infer(:v1)
      v2 = Variable.infer(:v2)
      edge = Edge.infer([v1, v2])
      edge.should be_a(Edge)
      edge.parent.should eql(v1)
      edge.child.should eql(v2)
    end
    
    it "should be able to take more than one parameter and use that as a parent, child indicator" do
      v1 = Variable.infer(:v1)
      v2 = Variable.infer(:v2)
      edge = Edge.infer(v1, v2)
      edge.should be_a(Edge)
      edge.parent.should eql(v1)
      edge.child.should eql(v2)
    end
    
    it "should be able to infer an Edge from a Hash" do
      edge = Edge.infer :parent => :p, :child => :c
      edge.parent.should be_a(Variable)
      edge.parent.name.should eql(:p)
      edge.child.should be_a(Variable)
      edge.child.name.should eql(:c)
    end
  end
end