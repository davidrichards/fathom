module Fathom

  class Entity
    include ActiveAttr::Model

    def self.hydrate(input)
      new(input)
    end

    def self.from_json(json)
      new(JSON(json))
    end

    def self.from_yaml(yaml)
      new(YAML.load(yaml))
    end

    def self.from_file(filename)
      case filename
      when /\.json$/
        from_json(File.read(filename))
      when /\.yaml$/, /\.yml$/
        from_yaml(File.read(filename))
      end
    end

  end
end
