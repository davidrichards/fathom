module Fathom
  class Variable
    
    # ============
    # = Behavior =
    # ============
    extend Plugins
    plugin AttributeSystem
    
    # ==============
    # = Attributes =
    # ==============
    attribute :name
    attribute :description
    
    def initialize(attrs={})
      @attributes = attrs
    end
    
  end # class Data
  
end