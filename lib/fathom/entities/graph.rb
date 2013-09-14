require File.expand_path('../entity', __FILE__)

=begin

  Notes:
  * The traversal is delegated to action objects.
  * The observations are observations that have occured while working with this graph.
    These block active trails, or create data independence (simplify subsequent queries).
    This is easily confused with the observations gathered to build graphs, but the two
    sets of observations have a different purpose.

=end

module Fathom
  class Graph < Entity
    attribute :priors,       default: {}
    attribute :factors,      default: []
    attribute :observations, default: {}
  end
end
