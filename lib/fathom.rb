require 'uuid'
require 'csv'
require 'yaml'
require 'json'
require 'active_attr'

module Fathom
end

$LOAD_PATH.unshift(File.expand_path('../fathom', __FILE__))
$LOAD_PATH.unshift(File.expand_path('../fathom/entities', __FILE__))
$LOAD_PATH.unshift(File.expand_path('../fathom/action_objects', __FILE__))

Dir["#{File.dirname(__FILE__)}/fathom/entities/**/*.rb"].each {|f| require f}
Dir["#{File.dirname(__FILE__)}/fathom/action_objects/**/*.rb"].each {|f| require f}


### SPIKE

# Dir["#{File.dirname(__FILE__)}/../test/support/**/*.rb"].each {|f| require f}
# include Fathom
#
# def graph
#   filename = File.expand_path('../../test/support/student.yaml', __FILE__)
#   contents = File.read(filename)
#   hash = YAML.load(contents)
#   @graph ||= Graph.new(hash)
# end
#
# def factor
#   @factor ||= graph.factors.select {|f| f.label == "grade"}.first
# end
#
# def factors
#   @factors ||= grade.factors
# end
#
# def query
#   @query ||= Query.new(conditions: {intelligence: 1})
# end
#
# def condition_factor
#   @condition_factor ||= ConditionFactor.new(factor, query)
# end
# alias :cf :condition_factor
#
# def condition(factor, query)
#   conditions = case query
#   when Query
#     query.conditions
#   when Hash
#     query
#   end
#   indices = factor.properties.inject({}) {|hash, parent| hash[parent] = hash.size + 1; hash}
#   select_query = query.conditions.inject({}) {|hash, (key, value)| hash[indices[key.to_s]] = value; hash}
#   filtered = factor.table.select do |key, probability|
#     select_query.all? {|index, value| key[index] == value}
#   end
#   sum = filtered.inject(0.0) {|s, (k, v)| s + v}
#   filtered.inject({}) do |hash, (key, value)|
#     hash[key] = value / sum
#     hash
#   end
# end
#
# # require 'sqlite3'
# # def db
# #   @db ||= SQLite3::Database.new ":memory:"
# # end
# #
# # def build_table
# #   db.execute "CREATE TABLE IF NOT EXISTS grade(value TEXT, difficulty INT, intelligence INT, probability REAL)"
# #   count = db.get_first_value( "select count(*) from grade" )
# #   if count == 0
# #     factor.table.each do |(value, difficulty, intelligence), probability|
# #       db.execute "INSERT INTO grade VALUES('#{value}',#{difficulty},#{intelligence},#{probability})"
# #     end
# #   end
# #   db.get_first_value( "select count(*) from grade" )
# # end
# #
# # def condition(attribute, value)
# #   build_table
# #   results = db.execute( "SELECT * FROM grade WHERE #{attribute} = ?", value ).to_a
# #   sum = results.inject(0.0) {|s, a| s + a[-1]}
# #   results.map do |array|
# #     probability = array.pop
# #     array << probability / sum
# #   end
# # end
