require 'active_support/core_ext/hash'

module Fathom

  class Entity
    include ActiveAttr::Model

    class << self
      def hydrate(input=nil)
        input.is_a?(self) ? input : new(input)
      end

      def from_json(json)
        new(JSON(json))
      end

      def from_yaml(yaml)
        new(YAML.load(yaml))
      end

      def from_file(filename)
        case filename
        when /\.json$/
          from_json(File.read(filename))
        when /\.yaml$/, /\.yml$/
          from_yaml(File.read(filename))
        end
      end
    end

    def as_json(*args)
      attributes
    end

    def serializable_hash(*args)
      as_json(*args)
    end

  end
end
