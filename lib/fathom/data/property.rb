module Fathom
  class Property
    
    # =================
    # = Class Methods =
    # =================
    class << self
      def infer(obj)
        new(:value => obj)
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
    attribute :value
    
    def initialize(attrs={})
      @attributes = attrs
    end
    
  end # Property
end # Fathom
    
    