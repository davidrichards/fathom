require File.expand_path('../../../spec_helper', __FILE__)

include Fathom

describe Variable do
  it "should have an attributes getter, built from initialization" do
    v = Variable.new(some: :value)
    v.attributes.should eql(some: :value)
  end
  
  it "should initialize a name accessor" do
    Variable.should have_an_initialization_accessor_for(:name)
  end
  
  it "should initialize a properties accessor" do
    Variable.should have_an_initialization_accessor_for(:properties)
  end
  
  it "should initialize a outcomes accessor" do
    Variable.should have_an_initialization_accessor_for(:outcomes)
  end
  
  it "should default the outcomes to [true, false]" do
    v = Variable.new
    v.outcomes.should eql([true, false])
  end

end