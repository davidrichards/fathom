require File.expand_path('../entity', __FILE__)

module Fathom
  class Graph < Entity
    attribute :priors,               default: {}
    attribute :adjacency_list,       default: []
    attribute :factors,              default: []
    attribute :local_observations,   default: {}

    def initialize(hash={})
      hash = hash.with_indifferent_access
      hash[:factors] = FactorList.hydrate(hash[:factors])
      super(hash)
    end
  end
end
