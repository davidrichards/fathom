require File.expand_path('../../../spec_helper', __FILE__)

include Fathom

describe NetworkPopulation do
  
  # ====================
  # = General Behavior =
  # ====================
  context "when acting like a context generally" do
    before {@class = NetworkPopulation}
    it_should_behave_like "a context"
    
    it "should have a default_class of Network" do
      @context = NetworkPopulation.new
      @context.object.should be_a(Network)
    end
  end
  
  # ==================
  # = YAML Importing =
  # ==================
  context "when importing records from YAML" do
    before do
      @network = Network.new
      @context = NetworkPopulation.new(@network)
    end

    it "should mixin the NetworkBuilder to the network" do
      @context.object.should_receive(:extend).with(NetworkBuilder).and_return(true)
      @context.object.stub(:from_hash) { true }
      @context.import_records_from_yaml
    end
    
    it "should expose from_hash on the network object" do
      @network.should_not respond_to(:from_hash)
      @context.import_records_from_yaml
      @network.should respond_to(:from_hash)
    end

    it "should be able to take a filename and process that." do
      yaml_contents = YAML.load(network_contents_in_yaml)
      YAML.should_receive(:load_file).with(network_contents_in_yaml_filename).and_return(yaml_contents)
      @context.import_records_from_yaml(:filename => network_contents_in_yaml_filename)
    end
    
    it "should rely on from_hash to convert the loaded YAML values into a serialized network" do
      yaml_contents = YAML.load(network_contents_in_yaml)
      @network.should_receive(:from_hash).with(yaml_contents).and_return(true)
      @context.import_records_from_yaml(:filename => network_contents_in_yaml_filename)
    end
    
  end
  
end