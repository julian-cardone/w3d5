# frozen_string_literal: true

require 'byebug'

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

  def dfs(target)
    return self if value == target

    children.each do |child|
      result = child.dfs(target)
      return result unless result.nil?
    end
    nil
  end

  def bfs(target)
    queue = [self]

    until queue.empty?
      dequeued = queue.shift
      return dequeued if dequeued.value == target

      dequeued.children.each do |child|
        queue.push(child)
      end
    end
    nil
  end

  def inspect
    { 'value' => value, 'parent_value' => parent.value, 'children' => children }.inspect
  end
end
# x = PolyTreeNode.new(:parent)
# y = PolyTreeNode.new(:child)
# z = PolyTreeNode.new(:child)
# y.parent = x

# x.children = [y, z]
