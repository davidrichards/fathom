class Array
  def invert(&block)
    h = {}
    self.each_with_index do |x, i|
      h[x] = block ? yield(x, i) : i
    end
    h
  end
end
