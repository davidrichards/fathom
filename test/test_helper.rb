require "minitest/autorun"
require "minitest/rg" unless ENV["NOCOLOR"]

require 'fathom'

$LOAD_PATH.unshift(File.dirname(__FILE__))

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
