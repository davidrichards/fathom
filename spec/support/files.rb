def network_contents_in_yaml_filename
  File.expand_path('../network.yml', __FILE__)
end

def network_contents_in_yaml
  File.read(network_contents_in_yaml_filename)
end

