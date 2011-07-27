# Tests that a value can be set with a parameters hash, and that an accessor is set on that field.
# Meaning: MyClass.new(:some_accessor => :some_value).some_accessor # => :some_value
# and obj = MyClass.new(:key => :value); obj.key = :new_value; obj.key # => :new_value
RSpec::Matchers.define :have_an_initialization_accessor_for do |attr|
  match do |klass|
    obj = klass.new(attr => :value)
    obj.send(attr).should eql(:value)
    obj.send("#{attr}=", :value2)
    obj.send(attr).should eql(:value2)
  end
end

