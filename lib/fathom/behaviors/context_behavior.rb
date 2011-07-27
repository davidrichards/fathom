module Fathom
  module ContextBehavior
  
    module ClassMethods
      
      def default_class(value=nil)
        @default_class = value if value
        @default_class
      end
      
      def new(*attrs, &block)
        target = attrs.shift
        target ||= default_class.new if default_class
        raise ArgumentError, "You must provide a target object to build this context." unless target
        obj = super(*attrs, &block)
        obj.send(:instance_variable_set, :@object, target)
        obj
      end
    end
  
    module InstanceMethods
      attr_reader :object
    end
    
    def self.configure(base)
    end
  end
end
