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

require 'list'

Dir["#{File.dirname(__FILE__)}/fathom/entities/**/*.rb"].each {|f| require f}
Dir["#{File.dirname(__FILE__)}/fathom/action_objects/**/*.rb"].each {|f| require f}
