class Tree
  def initialize(root = nil)
    @root = root
  end

  def get_element_by_id(id)
    holder = [@root]

    while (holder.length > 0)
      current = holder.pop
      return current if current[:value] == id
      holder.push(*current[:children])
    end
    nil
  end
end