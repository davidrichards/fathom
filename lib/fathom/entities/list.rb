require "delegate"
require "active_support/core_ext/module/attribute_accessors"

module Fathom
  def self.List klass
    list = DelegateClass(Array)
    list.class_eval do

      mattr_accessor :klass

      class << self

        def hydrate(array)
          new.hydrate(array)
        end

        def from_json(string)
          hydrate JSON(string)
        end

        def from_yaml(yaml)
          hydrate(YAML.load(yaml))
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

      def initialize(array=[])
        super([])
      end

      def <<(object)
        raise ArgumentError, "Can only add #{klass}" unless object.is_a?(klass)
        super
      end

      def []=(index, object)
        raise ArgumentError, "Can only add #{klass}" unless object.is_a?(klass)
        super
      end

      def hydrate(array)
        Array(array).each do |e|
          self << klass.hydrate(e)
        end
        self
      end

    end
    list.klass = klass
    list
  end
end
