require 'json'

module Fathom
  class ActionObject
    def self.execute!(*args)
      object = new(*args)
      object.execute!
    end

    def execute!
      raise NotImplementedError
    end
  end
end
