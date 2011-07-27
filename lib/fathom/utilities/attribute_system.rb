module Fathom
  
  # This is a simple way to use thin Ruby classes to only store data values for attributes.
  # In this way, we can have data models that can have various roles injected into them at
  # runtime and perform fairly well.  We can also have other kinds of data models mixed into 
  # Fathom, such as an ActiveRecord or DataMapper model, and we can just ignore this system
  # altogether.
  #
  # It is important that it is easy to set an attributes_proxy.  Other Fathom gems 
  # (say fm-redis, if I were to write that gem) could override the AttributeSystem default
  # attributes to store data in a Redis data store directly.  This is what the set_attributes_proxy
  # is designed to do here.
  #
  # Example Usage:
  # require 'memcache'
  # CACHE = MemCache.new 'localhost:11211', :namespace => 'my_project'
  # CACHE[1] = {:name => 'special'}
  # 
  # class MyClass
  #   extend Fathom::Plugins
  #   plugin Fathom::AttributeSystem
  #   
  #   attribute :name
  #   attribute :value, 1
  #   
  #   def initialize(attrs={})
  #     @attributes = attrs
  #   end
  # end
  # 
  # obj = MyClass.new(CACHE[1])
  # obj.name # => special
  # obj.value # => 1
  module AttributeSystem
  
    module ClassMethods
      
      # Define an attribute, or property of this class.
      # Useful for very thin, generic Ruby classes for Data models.
      def attribute(getter_name, default=nil)
        
        # Define a getter on the object
        define_method(getter_name) do
          
          target = send(self.class.attributes_proxy)

          return target[getter_name] unless target.respond_to?(:has_key?)

          if target.has_key?(getter_name)
            target[getter_name]
          else
            self.class.attribute_defaults[getter_name]
          end
        end

        # Define a setter on the object
        define_method("#{getter_name}=") do |value|
          send(self.class.attributes_proxy)[getter_name] = value
        end
        
        # Define a default on the object
        attribute_defaults[getter_name] = default
        
      end
      
      # Defines where the attributes are stored for the target class.
      def set_attributes_proxy(value)
        @attributes_proxy = value
      end
      
      def attributes_proxy
        @attributes_proxy ||= :attributes
      end
      
      def attribute_defaults
        @attribute_defaults ||= {}
      end
    end
    
    module InstanceMethods

      # Defines an attributes getter and defaults it to a Hash.
      def attributes
        @attributes ||= {}
      end
      
    end
    
  end # AttributeSystem
  
end # Fathom
