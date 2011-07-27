require File.expand_path('../../../spec_helper', __FILE__)

include Fathom

describe NetworkBuilder do
  
  before do
    @network = Network.new
    @network.extend NetworkBuilder
  end

  # =============
  # = from_hash =
  # =============
  context "when building a network from a hash" do
    # ===========================
    # = Top-level Functionality =
    # ===========================
    it "should have a from_hash method" do
      @network.should respond_to(:from_hash)
    end

    it "should merge the attributes with the new hash" do
      @network.from_hash name: :special
      @network.attributes.should eql(name: :special)
    end

    it "should provide the name directly" do
      @network.from_hash name: :special
      @network.name.should eql(:special)
    end

    # ==========================
    # = Variable Serialization =
    # ==========================
    it "should convert the variables to serialized Variables" do
      @network.from_hash variables: [{name: :arrived}, {name: :happy}]
      @network.variables.all? {|p| p.is_a?(Variable)}.should be_true
    end

    it "should convert the variables to an array" do
      @network.from_hash variables: Variable.new(name: :temperature_at_noon)
      @network.variables.should be_a(Array)
    end

    # ==========================
    # = Property Serialization =
    # ==========================
    it "should convert the properties to serialized Properties" do
      @network.from_hash properties: [1, 2, 3]
      @network.properties.all? {|p| p.is_a?(Property)}.should be_true
      @network.properties.map {|p| p.value }.should eql([1,2,3])
    end

    it "should convert the properties to an array" do
      @network.from_hash properties: 1
      @network.properties.should be_a(Array)
    end

    # ======================
    # = Edge Serialization =
    # ======================
    it "should convert the edges to serialized Edges" do
      @network.from_hash edges: {parent: 1, child: 2}
      @network.edges.all? {|p| p.is_a?(Edge)}.should be_true
    end

    it "should convert the edges to an array" do
      @network.from_hash edges: Edge.new
      @network.edges.should be_a(Array)
    end

    # ============================
    # = Definition Serialization =
    # ============================
    it "should convert the definitions to serialized Definitions" do
      @network.from_hash definitions: {for: :target, given: [:p1, :p2], table: [[0.1, 0.9], [0.3, 0.7]]}
      @network.definitions.all? {|p| p.is_a?(Definition)}.should be_true
    end

    it "should convert the definitions to an array" do
      @network.from_hash definitions: Definition.new
      @network.definitions.should be_a(Array)
    end

    # TODO: Come back to this and deal with the recursive nature of this process: basically, initialization and from_hash share a lot of behavior, and there's a case to be made to merge these.
    
  end # when building a network from a hash
  
end