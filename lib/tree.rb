class Tree
  def initialize(root = nil)
    @root = root
  end

  def get_element_by_id(id)
    holder = [@root]

    until holder.empty?
      current = holder.pop
      return current if current[:value] == id

      holder.push(*current[:children])
    end
    nil
  end
end