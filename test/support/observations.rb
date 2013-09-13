require 'csv'

def get_observations(filename="simple.csv")
  CSV.read(File.expand_path("../" + filename, __FILE__), converters: :all)
end
