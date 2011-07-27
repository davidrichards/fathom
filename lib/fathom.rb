module Fathom
  
  class Config
    attr_writer :storage
    def storage
      @storage ||= Hash
    end
  end
  
  # =================
  # = Configuration =
  # =================
  class << self
    # A reset-able configuration that provides access to other services (pod storage, say)
    def config
      @config ||= Config.new
    end
  
    # The reset on the configuration
    def reset_config!
      @config = Config.new
    end
  end
  
end

def path(path)
  File.expand_path("../fathom/#{path}", __FILE__)
end

# =============
# = Utilities =
# =============
Fathom.autoload :AttributeSystem, path('utilities/attribute_system')
Fathom.autoload :Plugins, path('utilities/plugins')

# ===============
# = Data Models =
# ===============
Fathom.autoload :Edge, path('data/edge')
Fathom.autoload :Network, path('data/network')
Fathom.autoload :Variable, path('data/variable')

