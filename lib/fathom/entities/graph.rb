require File.expand_path('../entity', __FILE__)

module Fathom
  class Graph < Entity
    attribute :priors, default: {}
    attribute :factors, default: []
  end
end
