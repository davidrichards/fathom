def simple_factor_json_filename
  File.expand_path('../simple_factor.json', __FILE__)
end

def simple_factor
  Fathom::Factor.from_file(simple_factor_json_filename)
end

def simple_factor_yaml_filename
  File.expand_path('../simple_factor.yaml', __FILE__)
end

def simple_factor_yml_filename
  File.expand_path('../simple_factor.yml', __FILE__)
end
