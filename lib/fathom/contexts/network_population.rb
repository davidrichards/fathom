module Fathom
  class NetworkPopulation
    # ============
    # = Behavior =
    # ============
    extend Plugins
    plugin ContextBehavior
    default_class Network
    
    # Uses YAML to populate a network.  
    # Expects a format in the YAML that mirrors the data models we are using.
    # 
    # Dependencies:
    # * yaml (standard library)
    # * open-uri (standard library)
    # 
    # Roles: NetworkBuilder
    # 
    # Usage:
    # @context = NetworkPopulation.new(some_network)
    # @context.import_records_from_yaml(:filename => 'some_network.yml')
    def import_records_from_yaml(opts={})
      require 'yaml'
      require 'open-uri'
      object.extend NetworkBuilder
      hash = extract_data_hash_from_parameters(opts)
      object.from_hash(hash)
    end
    
    protected
    
      # Contract: return a hash, the best one you can find, or an empty one.
      def extract_data_hash_from_parameters(opts)
        if opts[:filename]
          data_from_yaml_file(opts[:filename])
        else
          {}
        end
      end

      # Contract: return a hash or raise an error
      def data_from_yaml_file(filename)
        YAML.load_file(filename)
      end
    
  end
end
