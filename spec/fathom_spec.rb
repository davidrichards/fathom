require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Fathom do
  
  context "when configuring Fathom" do
    
    after do
      Fathom.reset_config!
    end
    
    it "should have a config" do
      Fathom.config.should be_a(::Fathom::Config)
    end
    
    it "should be configured automatically to use a Hash for storage" do
      Fathom.config.storage.should eql(Hash)
    end
    
    it "should be able to set the storage" do
      Fathom.config.storage = :another_storage_option
      Fathom.config.storage.should eql(:another_storage_option)
    end
    
    it "should use the String extensions" do
      "test".should respond_to(:underscore)
    end
    
  end
  
  
end
