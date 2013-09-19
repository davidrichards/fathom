module Fathom

  class Entity
    include ActiveAttr::Model

    class << self
      def hydrate(input)
        new(input)
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

      # For typecasting
      def call(*attrs)
        if attrs[0].is_a?(Array)
          attrs[0].map { |o| o.is_a?(self) ? o : new(o) }
        else
          new(*attrs)
        end
      end
    end

    alias_method :to_hash, :serializable_hash

  end
end
