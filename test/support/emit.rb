require 'csv'

# emit_data({{a: 1, b: 1} => 1, {a: 1, b: 0} => 2, {a: 0, b: 1} => 3, {a: 0, b: 0} => 4}, 100)
# Returns 100 random rows, proportional to the constraint_hash
# Use integers for the values
def emit_data(constraint_hash, n=1)
  sum = constraint_hash.inject(0) { |s, (k, v)| s + v }
  numerator = 0
  output_map = constraint_hash.inject({}) { |hash, (k, v)| hash[Rational(numerator += v, sum)] = k; hash }
  n.times.map { lookup_map(output_map, rand) }
end

# Expects incrementing keys
def lookup_map(output_map, value)
  output_map.select { |k, v| value <= k }.to_a.first.last.values
end

def sample_variables
  [
    Variable.new(label: 'a', domain: [1,0]),
    Variable.new(label: 'b', domain: %w(x y), parents: ['a']),
    Variable.new(label: 'c', domain: [1,0]),
    Variable.new(label: 'd', domain: %w(yes no), parents: %w(b c))
  ]
end

def sample_parent_labels
  %w(a c)
end

def hash_from_ordered_values(target_label, parent_labels, array)
  key = {target_label => array[0]}
  array[1..-1].each_with_index do |e, i|
    key[parent_labels[i]] = e
  end
  key
end

def sample_table_keys
  return @table_keys if @table_keys

  variables        = sample_variables.dup
  first_variable   = variables.shift
  domain           = first_variable.domain
  label            = first_variable.label
  variable_domains = variables.map(&:domain)
  variable_labels  = variables.map(&:label)
  domain_product   = domain.product(*variable_domains)

  @table_keys = domain_product.inject([]) do |table_keys, array|
    table_keys << hash_from_ordered_values(label, variable_labels, array)
  end

end

def incremental_observations(table_keys, n=nil)
  constraints = (1..table_keys.size).to_a
  n ||= table_keys.size * 10
  constraint_hash = build_constraint_hash(table_keys, constraints)
  emit_data(constraint_hash, n)
end

def build_constraint_hash(table_keys, constraints)
  output = {}
  table_keys.each_with_index do |key, i|
    output[key] = constraints[i]
  end
  output
end

def sample_observations
  @sample_observations ||= incremental_observations(sample_table_keys)
end

def observation_array_to_csv(header, observation_array, filename)
  CSV.open(filename, "wb") do |csv|
    csv << header
    observation_array.each do |row|
      csv << row
    end
  end
  true
end

def build_a_to_d
  filename = File.expand_path('../a_to_d.csv', __FILE__)
  headers = %w(a b c d)
  observation_array_to_csv(headers, sample_observations, filename)
end
