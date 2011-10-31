module Fathom
  module Plugins
    def plugins
      @plugins ||= []
    end

    def plugin(mod)
      return true if plugins.include?(mod)
      include mod unless mod.const_defined?(:InstanceMethods)
      extend mod::ClassMethods if mod.const_defined?(:ClassMethods)
      include mod::InstanceMethods if mod.const_defined?(:InstanceMethods)
      mod.configure(self) if mod.respond_to?(:configure)
      plugins << mod
    end
  end
  
end