module Fathom
  class Variable
    
    # =================
    # = Class Methods =
    # =================
    class << self
      def infer(obj)
        case obj
        when Variable
          obj
        when Hash
          new(obj)
        when Symbol, String
          new(:name => obj)
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
    attribute :name
    attribute :properties
    attribute :outcomes, [true, false]
    attribute :prior_odds
    
    def initialize(attrs={})
      @attributes = attrs
      self.prior_odds ||= uniform_set.dup
    end
    
    def underscored_name
      name.to_s.gsub(/\W/, "_").underscore
    end
    
    def eql(other)
      return false unless other.is_a?(Variable)
      self.name == other.name
    end
    alias :== :eql
    
    protected
      def uniform_set
        size = self.outcomes.size
        Array.new(size, 1/size.to_f)
      end
    
  end # class Data
  
end