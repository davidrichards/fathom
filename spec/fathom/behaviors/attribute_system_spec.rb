require File.expand_path('../../../spec_helper', __FILE__)

include Fathom

describe AttributeSystem do

  context "when checking the default nature of a class that has plugged in AttributeSystem" do
    
    before do
      @class = Class.new do
        extend Plugins
        plugin AttributeSystem
      end
    end

    it "should have an attributes getter" do
      obj = @class.new
      obj.should respond_to(:attributes)
    end
    
    it "should default the attributes to a Hash" do
      obj = @class.new
      obj.attributes.should eql({})
    end
  end
  
  context "when proxying to another object" do
    
    before do
      @class = Class.new do
        extend Plugins
        plugin AttributeSystem
      end
    end
    
    it "should default the attributes_proxy to :attributes" do
      @class.attributes_proxy.should eql(:attributes)
    end
    
    it "should be able to set_attributes_proxy" do
      @class.set_attributes_proxy :some_method
      @class.attributes_proxy.should eql(:some_method)
    end
  end
  
  context "when defining an attribute" do
    
    before do
      @class = Class.new do
        extend Plugins
        plugin AttributeSystem
      end
    end
    
    it "should have an attribute method" do
      @class.should respond_to(:attribute)
    end
    
    it "should be able to take an attribute name and have a setter and getter on that" do
      @class.attribute(:name)
      obj = @class.new
      obj.name = :name
      obj.name.should eql(:name)
    end
    
    it "should be able to read from the attributes object" do
      @class = Class.new do
        extend Plugins
        plugin AttributeSystem
        attribute :name
        def initialize
          @attributes = {:name => :value}
        end
      end
      obj = @class.new
      obj.name.should eql(:value)
    end
    
    it "should follow the proxied attributes, if it's been changed" do
      @class = Class.new do
        extend Plugins
        plugin AttributeSystem

        attribute :name
        set_attributes_proxy :alternate_attributes
        
        def alternate_attributes
          {:name => :value}
        end
      end
      obj = @class.new
      obj.name.should eql(:value)
    end
    
    it "should be able to set an attribute with a default" do
      @class.attribute(:name, :default)
      obj = @class.new
      obj.name.should eql(:default)
    end
    
    it "should not use the default if the attribute has been set" do
      @class.attribute(:name, :default)
      obj = @class.new
      obj.name.should eql(:default)
      obj.name = :changed
      obj.name.should eql(:changed)
    end
    
    it "should not use the default if the underlying attribute has been set" do
      @class = Class.new do
        extend Plugins
        plugin AttributeSystem
        attribute :name, :default
        
        def initialize(attrs={})
          @attributes = attrs
        end
      end
      
      obj = @class.new :name => :changed
      obj.name.should eql(:changed)
    end


    it "should not use the default if the underlying attribute has been set" do
      @class = Class.new do
        extend Plugins
        plugin AttributeSystem
        attribute :name, :default
        
        def initialize(attrs={})
          @attributes = attrs
        end
      end
      
      obj = @class.new :name => nil
      obj.name.should be_nil
    end
  end
  
end