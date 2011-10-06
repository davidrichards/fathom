require File.expand_path('../../../spec_helper', __FILE__)

include Fathom

describe Variable do
  
  # ==================
  # = Initialization =
  # ==================
  it "should have an attributes getter, built from initialization" do
    v = Variable.new(some: :value)
    v.attributes.should eql({:some => :value, :prior_odds => [0.5, 0.5]})
  end
  
  it "should initialize a name accessor" do
    Variable.should have_an_initialization_accessor_for(:name)
  end
  
  it "should have an underscored_name" do
    v = Variable.new(:name => "a Very special name, don't you think?")
    v.underscored_name.should eql("a_very_special_name__don_t_you_think_")
  end
  
  it "should initialize a properties accessor" do
    Variable.should have_an_initialization_accessor_for(:properties)
  end
  
  it "should initialize an outcomes accessor" do
    Variable.should have_an_initialization_accessor_for(:outcomes)
  end
  
  it "should default the outcomes to [true, false]" do
    v = Variable.new
    v.outcomes.should eql([true, false])
  end
  
  it "should initialize a prior_odds accessor" do
    Variable.should have_an_initialization_accessor_for(:prior_odds)
  end
  
  it "should default the prior odds to the uniform set for the outcomes" do
    v = Variable.new
    v.prior_odds.should eql([0.5, 0.5])
    v = Variable.new :outcomes => [:a, :b, :c]
    v.prior_odds.should eql([1/3.0, 1/3.0, 1/3.0])
  end
  
  # =================
  # = Equality (==) =
  # =================
  it "should be equal by name" do
    v1 = Variable.new(:name => :name)
    v2 = Variable.new(:name => :name)
    v1.should ==(v2)
  end

  # =========
  # = Infer =
  # =========
  context "when infering" do
    it "should be able to infer from a variable" do
      @v1 = Variable.new
      Variable.infer(@v1).should eql(@v1)
    end
    
    it "should be able to infer from a hash" do
      @hash = {:name => :name, :prior_odds => [0.4, 0.6]}
      @v1 = Variable.new(@hash)
      Variable.infer(@hash).should ==(@v1)
    end
    
    it "should be able to infer from a symbol" do
      @symbol = :name
      @v1 = Variable.new(:name => @symbol)
      Variable.infer(@symbol).should ==(@v1)
    end

    it "should be able to infer from a string" do
      @string = 'name'
      @v1 = Variable.new(:name => @string)
      Variable.infer(@string).should ==(@v1)
    end

  end

end