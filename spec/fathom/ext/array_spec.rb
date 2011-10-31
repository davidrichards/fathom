require File.expand_path('../../../spec_helper', __FILE__)

describe Array do

  it "should be able to invert an array" do
    [:a, :b, :c].invert.should eql({:a => 0, :b => 1, :c => 2})
  end
  
  it "should be able to invert an array with an optional block" do
    keys = [4,5,6]
    array = [:a, :b, :c]
    inverted = array.invert do |x, i|
      keys[i]
    end
    inverted.should eql({:a => 4, :b => 5, :c => 6})
  end
end