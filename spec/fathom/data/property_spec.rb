require File.expand_path('../../../spec_helper', __FILE__)

include Fathom

describe Property do
  
  it "should initialize a value accessor" do
    Property.should have_an_initialization_accessor_for(:value)
  end
  
  it "should have an infer constructor" do
    property = Property.infer(:some_value)
    property.should be_a(Property)
    property.value.should eql(:some_value)
  end

end