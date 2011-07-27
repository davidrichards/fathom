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
    attribute :nodes
    
    def initialize(attrs={})
      @attributes = attrs
    end
    
    # ====================
    # = Instance Methods =
    # ====================
    def each(&block)
      nodes.each do |node|
        yield node
      end
    end
    
  end
end
