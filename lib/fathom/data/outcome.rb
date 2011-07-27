module Fathom
  class Outcome
    
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
    
  end # Outcome
end # Fathom
    
