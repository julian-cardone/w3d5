class PolyTreeNode
  attr_reader :value, :parent, :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  # "does not add the same node twice"
  def parent=(node)
    old_parent = parent
    @parent = node
    old_parent&.children&.delete(self)

    node.children.push(self) if !node.nil? && !node.children.include?(self)
  end

  def add_child(node)
    node.parent = self
  end

  def remove_child(node)
    raise 'Cannot remove, not a child' unless node.parent

    node.parent = nil
  end

  def dfs(value)
    return self if self.value == value

    children.each do |child|
      if !dfs(child.value).nil?
        return dfs(child.value)
      end
    end
    nil
  end

  def bfs(value); end
end
# x = PolyTreeNode.new(:parent)
# y = PolyTreeNode.new(:child)
# z = PolyTreeNode.new(:child)
# y.parent = x

# x.children = [y, z]
