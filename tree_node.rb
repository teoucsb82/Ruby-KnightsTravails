class TreeNode

  attr_accessor :value, :children, :parent

  def initialize(value)
    @value = value
    @children = []
  end

  def remove_child(child_node)
    captured_child = self.children.delete(child_node)
    captured_child.parent = nil
  end

  def add_child(child_node)
    child_node.parent.remove_child(child_node) unless child_node.parent.nil?

    self.children << child_node
    child_node.parent = self
  end

  def dfs(target_value)
    # target_child = nil
    return self if target_value == self.value

    #This searches deeply because of the way the loop iterates through each child's children
    self.children.each do |child|
      target_child = child.dfs(target_value)
      return target_child unless target_child.nil?
    end

    nil
  end

  def bfs(target_value)
    queue = [self]

    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target_value
      queue.push *current_node.children
    end

    nil
  end

  def path
    trail = []
    current = self

    #Ryan version
    until current.parent.nil?
      trail << current.value
      current = current.parent
    end
    trail << current.value
    trail.reverse

    # Malcolm & Teo Version
    # while true
    #   trail << current.value
    #   current = current.parent
    #   if current.parent.nil?
    #     trail << current.value
    #     return trail.reverse
    #   end
    # end
    # nil

  end
end

a = TreeNode.new(5)
b = TreeNode.new(6)
c = TreeNode.new(7)
d = TreeNode.new(8)
c.add_child(d)
b.add_child(c)
a.add_child(b)

p d.path