module Fathom
  class Edge
    
    # =============
    # Class Methods
    # =============
    class << self
      def infer(obj)
        case obj
        when Edge
          obj
        when Array
          new(:parent => infer(obj[0]), :child => infer(obj[1]))
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
