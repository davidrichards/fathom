require File.expand_path('../entity', __FILE__)

module Fathom
  class Variable < Entity
    attribute :dependent_label, type: String
    attribute :dependent_values, default: []
    attribute :independents, default: {}
  end
end
