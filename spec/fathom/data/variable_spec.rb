require File.expand_path('../../../spec_helper', __FILE__)

include Fathom

describe Variable do
  it "should have an attributes getter, built from initialization" do
    v = Variable.new(some: :value)
    v.attributes.should eql(some: :value)
  end
  
  it "should initialize with a name" do
    v = Variable.new(:name => :a)
    v.name.should eql(:a)
  end
  
  it "should initialize with a description" do
    v = Variable.new(:description => :description)
    v.description.should eql(:description)
  end
end