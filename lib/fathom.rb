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
Dir["#{File.dirname(__FILE__)}/../test/support/**/*.rb"].each {|f| require f}


###

include Fathom
def variable_definitions
  [{
    label: 'a',
    values: [1, 0],
    parents: {
      'b' => [1,0]
    }
  }]
end

def bg
  @bg ||= BuildGraph.new(variable_definitions, get_observations)
end

def yaml
  require 'yaml'
  YAML.dump bg.graph
end
