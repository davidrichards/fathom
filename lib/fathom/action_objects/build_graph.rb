# =begin
#   Get observations
#   Sort them
#   Combine them
#   Group them
#   Count them
#   Correlation matrices
#   Suggested graph structure
#   Gather factor frequencies
#   Build factors (continuous and discrete)
# =end
#
# =begin
#
#   Build Graph
#   ===========
#
#   Data:
#
#   * Observation Grids (CSV w/ header)
#   * Graph (hash)
#
#   Primary Course:
#
#   * User submits a CSV or several of them
#   * System extracts the headers and chooses a sort column
#   * System sorts the observations
#
# =end
#
# require File.expand_path('../action_object', __FILE__)
#
# module Fathom
#   class BuildGraph < ActionObject
#
#     def inspect
#       @inspect ||= "BuildGraph (#{data.size}) #{header.inspect}"
#     end
#
#     attr_reader :csv
#
#     def initialize(csv)
#       @csv = csv
#     end
#
#     def header
#       @header ||= csv[0]
#     end
#
#     def data
#       @data ||= csv[1..-1]
#     end
#
#     attr_writer :sort_fields
#     def sort_fields
#       @sort_fields ||= [0]
#     end
#
#     def transposed
#       @transposed ||= data.transpose
#     end
#
#     def correlations
#       @correlations ||= transposed.combination(2).map do |x, y|
#         ruby_pearson x, y
#       end
#     end
#
#     def correlation_labels
#       @correlation_labels ||= header.map {|e| [e] }.combination(2).to_a
#     end
#
#     def correlations_with_labels
#       output = {}
#       correlation_labels.each_with_index do |label, index|
#         output[label] = correlations[index]
#       end
#       output.sort {|a, b| a[1] <=> b[1]}
#     end
#
#     def sort!
#       @transposed = nil
#       data.sort! { |a, b| sort_fields.map{|i| a[i]} <=> sort_fields.map{|i| b[i]} }
#     end
#
#     def ruby_pearson(x,y)
#       begin
#         n = x.length
#
#         sum_x = x.inject(0) {|r,i| r + i}
#         sum_y = y.inject(0) {|r,i| r + i}
#
#         sum_x_squared = x.inject(0) {|r,i| r + i**2}
#         sum_y_squared = y.inject(0) {|r,i| r + i**2}
#
#         prods = []; x.each_with_index{|this_x,i| prods << this_x*y[i]}
#         p_sum = prods.inject(0){|r,i| r + i}
#
#         # Calculate Pearson score
#         num = p_sum-(sum_x*sum_y/n)
#         den = ((sum_x_squared-(sum_x**2)/n)*(sum_y_squared-(sum_y**2)/n))**0.5
#         if den == 0
#           return 0
#         end
#         r = num/den
#         return r
#       rescue
#         0
#       end
#     end
#
#   end
# end
#
# # require 'csv'
# # def csv
# #   @csv ||= CSV.read("data/football.csv", converters: :all)
# # end
# #
# # include Fathom
# # F = BuildGraph
# #
# # def bg
# #   @bg ||= F.new(csv)
# # end
