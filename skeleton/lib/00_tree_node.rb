class PolyTreeNode
require 'byebug'

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

  def dfs(target)
    return nil if self.nil?
    return self if self.value == target
    children.each do |child|
      result = child.dfs(target)
      return result if result.value == target
      
      if result.is_a?(Array) && result.empty?
      end
    end
  end

  def bfs(value); end

  def inspect
    { 'value' => value, 'parent_value' => parent.value, 'children' => children}.inspect
  end

end
# x = PolyTreeNode.new(:parent)
# y = PolyTreeNode.new(:child)
# z = PolyTreeNode.new(:child)
# y.parent = x

# x.children = [y, z]
