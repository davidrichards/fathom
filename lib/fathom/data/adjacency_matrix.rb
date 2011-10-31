module Fathom
  class AdjacencyMatrix
    
    include Enumerable
    
    def initialize(default=0)
      @default = default
      @store = Hash.new(default)
    end
  
    def [](parent, child)
      @store[[parent, child]]
    end
  
    def []=(parent, child, value)
      if value == @default
        @store.delete([parent, child]) # preserves a little memory
      else
        @store[[parent, child]] = value
      end
    end
    
    def each
      @store.each {|k, v| yield(k,v)}
    end
  end
end
