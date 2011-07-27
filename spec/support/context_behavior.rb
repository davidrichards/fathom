shared_examples_for "a context" do

  it "should take an object and expose that object through a reader" do
    obj = double('some data object')
    context = @class.new(obj)
    context.object.should eql(obj)
  end
  
  it "should raise an error if no target is provided at initialization" do
    @class.send(:instance_variable_set, :@default_class, nil)
    lambda{@class.new}.should raise_error(ArgumentError, /You must provide a target object to build this context./)
  end

end
