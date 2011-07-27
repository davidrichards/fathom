require File.expand_path('../../../spec_helper', __FILE__)

include Fathom

describe ContextBehavior do
  it "should be able to set a default_class" do
    @class = Class.new do
      extend Plugins
      plugin ContextBehavior
      default_class Hash
    end
    obj = @class.new
    obj.object.should eql({})
  end
end