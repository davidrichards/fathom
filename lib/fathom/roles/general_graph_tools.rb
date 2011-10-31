module Fathom
  module GeneralGraphTools
    
    def adjacency_matrix
      @adjacency_matrix ||= AdjacencyMatrix.new
    end
    
    def add_edge(parent, child)
      self.variables |= [parent, child]
      self.adjacency_matrix[parent, child] = 1
    end
    
    def remove_edge(parent, child)
      return false unless self.variables.include?(parent) and self.variables.include?(child)
      self.adjacency_matrix[parent, child] = 0
    end
    
    def at(parent, child)
      self.adjacency_matrix[parent, child]
    end
    alias :[] :at
    
    def edge?(parent, child)
      return false unless ([parent, child] - self.variables).empty?
      self.adjacency_matrix[parent, child] == 1
    end
    
    # Implemented as an out-degree
    def degree(node)
      found = self.adjacency_matrix.select do |(parent, child), value|
        parent == node
      end
      found.size
    end
    
    def each_vertex
      self.variables.each {|v| yield v}
    end
    
    def each_edge
      self.adjacency_matrix.each {|(parent, child), value| yield parent, child}
    end
    
    # Find whether the graph is connected, based on notes here:
    # http://www.ics.uci.edu/~eppstein/161/960201.html
    # This assumes that all variables in the network have been added 
    # to the adjacency matrix.
    def connected?
      x = self.variables[0] # Arbitrary first node
      reachable_vertices = [x]
      vertices_to_explore = [x]

      while !vertices_to_explore.empty?
        y = vertices_to_explore.shift
        self.each_edge do |parent, child|
          unless reachable_vertices.include?(child)
            vertices_to_explore << child
            reachable_vertices << child
          end
        end
      end
      
      reachable_vertices.size < self.variables.size ? false : true
      
    end

    def parents(node)
      output = []
      self.adjacency_matrix.each do |(parent, child), value|
        output << parent if child == node
      end
      output
    end
    
    def children(node)
      output = []
      self.adjacency_matrix.each do |(parent, child), value|
        output << child if parent == node
      end
      output
    end
    
    def topological_sort!
      sorted = []
      unmarked = self.variables.inject({}) do |hash, variable|
        hash[variable] = parents(variable)
        hash
      end
      self.variables.each do |variable|
        found, parents = unmarked.find {|v, a| a.all?{|e| unmarked[e].nil?}}
        unmarked.delete(found)
        sorted << found
      end
      self.variables = sorted.dup
      sorted
    end

    def euler_circuit?
      return false if !connected?
      self.each_vertex do |v|
        return false if degree(v) % 2 != 0
      end
      true
    end
    
    def euler_path?
      return false if !connected?
      odd=0
      self.each_vertex do |v|
        if degree(v) % 2 == 1
          odd += 1
        end
      end
      odd <= 2
    end
    
  end
end
