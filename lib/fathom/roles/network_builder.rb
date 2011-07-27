module Fathom
  
  # This is the role necessary for importing nodes, shaping graphs, adding edges, that sort of thing.
  module NetworkBuilder
    def from_hash(hash)
      hash = serialize_hash(hash)
      attributes.merge!(hash)
    end
    
    protected
    
      def serialize_hash(hash)
        hash.inject({}) do |h, (key, value)|

          value = [value] if attribute_should_be_an_array(key) and not value.is_a?(Array)

          if klass = serialization_class_for(key)
            value = infer_serialized_array(value, klass)
          end

          h[key] = value

          h
        end
      end
      
      def serialization_class_for(attribute)
        serialization_map[attribute]
      end
      
      def serialization_map
        @serialization_map ||= {
          definitions: Definition,
          edges: Edge,
          properties: Property,
          variables: Variable
        }
      end
      
      def attribute_should_be_an_array(attribute)
        array_conversion_attributes.include?(attribute)
      end
      
      def array_conversion_attributes
        @array_conversion_map ||= [:properties, :variables, :edges, :definitions]
      end
      
      # Uses the Class.infer, if available.  Otherwise initializes the value passed in.
      def infer_serialized_array(array, klass)
        array.map do |e|
          if klass.respond_to?(:infer)
            klass.infer(e)
          else
            klass.new(e)
          end
        end
      end
  end
end