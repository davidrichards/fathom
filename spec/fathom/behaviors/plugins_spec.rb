require File.expand_path('../../../spec_helper', __FILE__)

include Fathom

module PluginDemoModule
  module InstanceMethods
    def special_instance_method
      :special_instance_method
    end
  end
  
  module ClassMethods
    def special_class_method
      :special_class_method
    end
    
    def special_configuration_method
      @especially_configured = true
    end
    
    attr_reader :especially_configured
  end
  
  def self.configure(mod)
    mod.special_configuration_method
  end
end

module PlainDemoModule
  def plain_instance_method
    :plain_instance_method
  end
end


describe Plugins do

  before do
    @class = Class.new do
      extend Plugins
      plugin PluginDemoModule
    end
  end
  
  after(:all) do
    Object.send(:remove_const, :PluginDemoModule)
    Object.send(:remove_const, :PlainDemoModule)
  end
  
  it "should have a plugins array" do
    @class.plugins.should eql([PluginDemoModule])
  end
  
  it "should be able to add a new plugin" do
    @class.plugins.should eql([PluginDemoModule])
  end
  
  it "should make the ClassMethods available to the class" do
    @class.special_class_method.should eql(:special_class_method)
  end
  
  it "should make the InstanceMethods available on an instance" do
    obj = @class.new
    obj.special_instance_method.should eql(:special_instance_method)
  end
  
  it "should include a plain module if it is not a Plugin (has InstanceMethods)" do
    @class = Class.new do
      extend Plugins
      plugin PlainDemoModule
    end
    obj = @class.new
    obj.plain_instance_method.should eql(:plain_instance_method)
  end
  
  it "should have called the configure method in the plugin" do
    @class.especially_configured.should be_true
  end
  
end
