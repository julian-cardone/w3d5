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
end

# x = PolyTreeNode.new(:parent)
# y = PolyTreeNode.new(:child)
# z = PolyTreeNode.new(:child)
# y.parent = x

# x.children = [y, z]
