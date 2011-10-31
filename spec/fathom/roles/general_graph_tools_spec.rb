require File.expand_path('../../../spec_helper', __FILE__)

include Fathom

describe NetworkBuilder do
  
  before do
    @network = Network.new
    @network.extend GeneralGraphTools
  end
  
  context "when using the adjacency matrix" do
    it "should offer an adjacency matrix to the network" do
      @network.adjacency_matrix.should be_an(AdjacencyMatrix)
    end
    
    it "should default unknown values to 0" do
      @network.adjacency_matrix[:parent, :child].should eql(0)
    end
    
    it "should record edges in the adjacency matrix with add_edge" do
      v1 = Variable.new()
      v2 = Variable.new()
      @network.add_edge(v1, v2)
      @network.variables.should eql([v1, v2])
      @network.at(v1, v2).should eql(1)
    end
    
    it "should remove edges, but not the variables" do
      v1 = Variable.new()
      v2 = Variable.new()
      @network.add_edge(v1, v2)
      @network.remove_edge(v1, v2)
      @network.variables.should eql([v1, v2])
      @network.at(v1, v2).should eql(0)
    end
    
    it "should work for non-variables" do
      @network.add_edge(:one, :two)
      @network.at(:one, :two).should eql(1)
    end
    
    it "should have [] as an alias for 'at'" do
      @network.add_edge :one, :two
      @network.at(:one, :two).should eql(1)
      @network[:one, :two].should eql(1)
    end
    
    context "when iterating on the graph" do
      before do
        @network.add_edge :one, :two
        @network.add_edge :one, :three
      end
      
      it "should be able to lookup the out-degree of a variable" do
        @network.degree(:one).should eql(2)
        @network.degree(:two).should eql(0)
      end
    
      it "should have an iterator on each_vertex" do
        found = []
        @network.each_vertex {|v| found << v }
        found.should eql([:one, :two, :three])
      end
      
      it "should have an iterator on each_edge" do
        found = []
        @network.each_edge {|p, c| found << [p,c] }
        found.should eql([[:one, :two], [:one, :three]])
      end
      
      it "should return whether the graph is connected" do
        # 1 -> 2 and 1 -> 3
        @network.should be_connected

        @network = Network.new
        @network.extend GeneralGraphTools
        @network.add_edge(:one, :two)
        @network.add_edge(:three, :four)

        # 1 -> 2
        # 3 -> 4
        @network.should_not be_connected
      end
      
    end
    
  end
  
  context "when performing a topological sort" do
    before do
      @network.add_edge :b, :d
      @network.add_edge :e, :g
      @network.add_edge :c, :e
      @network.add_edge :a, :b
      @network.add_edge :a, :c
      @network.add_edge :c, :f
    end
    
    it "should be able to perform a topological sort" do
      @network.topological_sort!.should eql([:a, :b, :d, :c, :e, :g, :f])
    end
    
    it "should change the order of the variables to the order of the sort" do
      @network.variables.should eql([:b, :d, :e, :g, :c, :a, :f])
      @network.topological_sort!
      @network.variables.should eql([:a, :b, :d, :c, :e, :g, :f])
    end

    # TODO: Think about this one...
    # it "should return false unless the graph is connected" do
    #   @network.add_edge :x, :y
    #   @network.topological_sort!.should be_false
    # end
    
  end
  
  it "should have an edge lookup tool" do
    v1, v2 = Variable.infer(:v1), Variable.infer(:v2)
    @network.add_edge(v1, v2)
    @network.edge?(v1, v2).should be_true
  end
end