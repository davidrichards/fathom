require File.expand_path('../entity', __FILE__)

module Fathom
  class Variable < Entity
    attribute :label, type: String
    attribute :domain, default: []
    attribute :parents, default: {}
  end
end
