require File.expand_path('../entity', __FILE__)

module Fathom
  class Factor < Entity
    attribute :label, type: String
    attribute :target
    attribute :parents, default: []
    attribute :type, default: "discrete", type: String
    attribute :table, default: {}

    def initialize(object={})
      case object
      when Factor
        super(object.attributes)
      when Hash
        hash = object.with_indifferent_access
        hash[:table] = hash.fetch(:table, {})
        hash[:target] = Variable.hydrate(hash[:target])
        super(hash)
      end
    end
  end
end
