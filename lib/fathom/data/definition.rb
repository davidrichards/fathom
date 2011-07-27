module Fathom
  class Definition
    
    # ============
    # = Behavior =
    # ============
    extend Plugins
    plugin AttributeSystem
    
    # ==============
    # = Attributes =
    # ==============
    attribute :for
    attribute :given
    attribute :table
    
    def initialize(attrs={})
      @attributes = attrs
    end
    
  end # Definition
end # Fathom
