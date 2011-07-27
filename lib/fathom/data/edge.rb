module Fathom
  class Edge
    
    # ============
    # = Behavior =
    # ============
    extend Plugins
    plugin AttributeSystem
    
    # ==============
    # = Attributes =
    # ==============
    attribute :is_directed, true
    
    def initialize(attributes={})
      @attributes = attributes
    end
  end
end
