require File.expand_path('../entity', __FILE__)
module Fathom
  class Query < Entity
    attribute :target, default: {}
    attribute :conditions, default: {}
  end
end
