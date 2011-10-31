module Fathom
  class Edge
    
    # =============
    # Class Methods
    # =============
    class << self
      def infer(obj, optional_child=nil)
        return new(:parent => Variable.infer(obj), :child => Variable.infer(optional_child)) if optional_child
        
        case obj
        when Edge
          obj
        when Array
          new(:parent => Variable.infer(obj[0]), :child => Variable.infer(obj[1]))
        when Hash
          new(obj)
        end
      end
    end
    
    # ============
    # = Behavior =
    # ============
    extend Plugins
    plugin AttributeSystem
    
    # ==============
    # = Attributes =
    # ==============
    attribute :is_directed, true
    attribute :parent
    attribute :child
    
    def initialize(attributes={})
      attributes[:parent] = Variable.infer(attributes[:parent])
      attributes[:child] = Variable.infer(attributes[:child])
      @attributes = attributes
    end
    
    # ============================================================
    # = Override setters on parent and child to ensure Variables =
    # ============================================================
    def parent=(obj)
      send(self.class.attributes_proxy)[:parent] = Variable.infer(obj)
    end
    
    def child=(obj)
      send(self.class.attributes_proxy)[:child] = Variable.infer(obj)
    end

    def eql(other)
      return false unless other.is_a?(Edge)
      self.parent == other.parent and self.child == other.child
    end
    alias :== :eql
  end
end
