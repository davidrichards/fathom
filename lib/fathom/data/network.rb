module Fathom
  class Network
    
    # ============
    # = Behavior =
    # ============
    extend Plugins
    include Enumerable
    plugin AttributeSystem
    
    # ==============
    # = Attributes =
    # ==============
    attribute :name
    attribute :variables
    attribute :properties
    attribute :edges
    attribute :definitions
    
    def initialize(attrs={})
      @attributes = attrs
    end
    
    # ====================
    # = Instance Methods =
    # ====================
    def each(&block)
      variables.each do |variable|
        yield variable
      end
    end
    
  end
end
