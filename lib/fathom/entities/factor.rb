require File.expand_path('../entity', __FILE__)

module Fathom
  class Factor < Entity
    attribute :label, type: String
    attribute :properties, default: {}
    attribute :type, default: "discrete", type: String
    attribute :table, default: {}
  end

  # class Factors < Array
  #   def self.call(array, *args)
  #     Array(array).map { |o| Factor.new(o) }
  #   end
  # end

end
