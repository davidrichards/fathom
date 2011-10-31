require File.expand_path('../../../spec_helper', __FILE__)

describe String do
  it "should be able to constantize a string" do
    "Object".constantize.should eql(Object)
  end
  
  it "should be able to camelize a lower-case and underscored word" do
    "this_is_it".camelize.should eql("ThisIsIt")
    "this_is_it".camelize(false).should eql("thisIsIt")
  end
  
  it "should be able to underscore a camel-cased word" do
    "ThisIsIt".underscore.should eql("this_is_it")
  end
  
  it "should be able to dasherize an underscored word" do
    "this_is_it".dasherize.should eql("this-is-it")
  end
  
  it "should be able to demodulize a module-looking word" do
    "This::Is::It".demodulize.should eql("It")
  end
  
  it "should be able to create a foreign key from a name" do
    "ThisIsIt".foreign_key.should eql("this_is_it_id")
  end
  
  context "when ordinalize-ing numbers" do
    it "should turn 1 to 1st" do
      "1".ordinalize.should eql("1st")
    end
    
    it "should turn 2 to 2nd" do
      "2".ordinalize.should eql("2nd")
    end
    
    it "should turn 3 to 3rd" do
      "3".ordinalize.should eql("3rd")
    end
    
    it "should turn 4 and so on to nth" do
      (4..20).each do |i|
        i.to_s.ordinalize.should eql("#{i}th")
      end
    end
  end
  
  it "should be able to wrap a string, defaulting to 80 characters" do
    source = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    expected =<<END
Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu
fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
culpa qui officia deserunt mollit anim id est laborum.
END
    source.wrap.should eql(expected)
  end
  
  it "should be able to take an arbitrary wrap length" do
    source = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    expected =<<END
Lorem ipsum dolor sit
amet, consectetur
adipisicing elit, sed do
eiusmod tempor
incididunt ut labore et
dolore magna aliqua. Ut
enim ad minim veniam,
quis nostrud
exercitation ullamco
laboris nisi ut aliquip
ex ea commodo consequat.
Duis aute irure dolor in
reprehenderit in
voluptate velit esse
cillum dolore eu fugiat
nulla pariatur.
Excepteur sint occaecat
cupidatat non proident,
sunt in culpa qui
officia deserunt mollit
anim id est laborum.
END
    source.wrap(24).should eql(expected)
  end
  
end
