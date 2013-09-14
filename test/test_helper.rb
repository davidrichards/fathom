require "minitest/autorun"
require "minitest/rg" unless ENV["NOCOLOR"]

require 'fathom'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
