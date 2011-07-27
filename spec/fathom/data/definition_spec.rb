require File.expand_path('../../../spec_helper', __FILE__)

include Fathom

describe Definition do

  it "should initialize a for accessor" do
    Definition.should have_an_initialization_accessor_for(:for)
  end
  
  it "should initialize a given accessor" do
    Definition.should have_an_initialization_accessor_for(:given)
  end
  
  it "should initialize a table accessor" do
    Definition.should have_an_initialization_accessor_for(:table)
  end
  
end