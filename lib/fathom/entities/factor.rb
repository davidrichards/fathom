require File.expand_path('../entity', __FILE__)

module Fathom
  class Factor < Entity
    attribute :name, type: String
    attribute :properties, default: {}
    attribute :type, default: "discrete", type: String
    attribute :table, default: {}
  end
end
