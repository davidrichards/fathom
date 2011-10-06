# ================
# = Dependencies =
# ================
Dir.glob("#{File.dirname(__FILE__)}/ext/*.rb").each { |file| require file}

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
# = Behaviors =
# =============
Fathom.autoload :AttributeSystem, path('behaviors/attribute_system')
Fathom.autoload :ContextBehavior, path('behaviors/context_behavior')
Fathom.autoload :Plugins, path('behaviors/plugins')

# ===============
# = Data Models =
# ===============
Fathom.autoload :Definition, path('data/definition')
Fathom.autoload :Edge, path('data/edge')
Fathom.autoload :Network, path('data/network')
Fathom.autoload :Outcome, path('data/outcome')
Fathom.autoload :Property, path('data/property')
Fathom.autoload :Variable, path('data/variable')

# ============
# = Contexts =
# ============
Fathom.autoload :NetworkPopulation, path('contexts/network_population')
Fathom.autoload :NetworkTraversal, path('contexts/network_traversal')

# =========
# = Roles =
# =========
Fathom.autoload :NetworkBuilder, path('roles/network_builder')
