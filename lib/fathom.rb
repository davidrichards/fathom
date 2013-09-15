require 'uuid'
require 'csv'
require 'yaml'
require 'json'
require 'active_attr'

module Fathom
end

$LOAD_PATH.unshift(File.expand_path('../fathom', __FILE__))
$LOAD_PATH.unshift(File.expand_path('../fathom/entities', __FILE__))
$LOAD_PATH.unshift(File.expand_path('../fathom/action_objects', __FILE__))

Dir["#{File.dirname(__FILE__)}/fathom/entities/**/*.rb"].each {|f| require f}
Dir["#{File.dirname(__FILE__)}/fathom/action_objects/**/*.rb"].each {|f| require f}


### SPIKE

Dir["#{File.dirname(__FILE__)}/../test/support/**/*.rb"].each {|f| require f}
include Fathom

def graph
  filename = File.expand_path('../../test/support/student.yaml', __FILE__)
  contents = File.read(filename)
  hash = YAML.load(contents)
  @graph ||= Graph.new(hash)
end

def factor
  @factor ||= graph.factors.select {|f| f.label == "grade"}.first
end

def condition(factor, query)

end
