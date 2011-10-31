Feature: Graph Methods
  In order to store knowledge in graphs
  As an analyst
  I want to be able to build a graph from a complete description

  Scenario: Building with a Hash
    Given a full description of a graph in a Hash format
    When I build a network from that description
    Then I should get a network with variables

  Scenario: Building with YAML
    Given a full description of a graph in a YAML format
    When I build a network from that description
    Then I should get a network with variables

  Scenario: Building with XMLBIF
    Given a full description of a graph in a XMLBIF format
    When I build a network from that description
    Then I should get a network with variables

  Scenario: Building a directed adjacency matrix
    Given a defined network
    When I ask it to build the adjacency matrix
    Then I should have a matrix that marks the edges between variables

  # Possibly I'll build more of the graph features here.  Certainly I'll finish them in the specs.