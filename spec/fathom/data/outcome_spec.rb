require File.expand_path('../../../spec_helper', __FILE__)

include Fathom

describe Outcome do
  
  it "should initialize a value accessor" do
    Outcome.should have_an_initialization_accessor_for(:value)
  end
  
  it "should have an infer constructor" do
    outcome = Outcome.infer(:some_value)
    outcome.should be_a(Outcome)
    outcome.value.should eql(:some_value)
  end

end