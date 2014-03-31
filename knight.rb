require './tree_node.rb'

class KnightPathFinder

  attr_accessor :starting_pos, :move_tree

  def initialize(starting_pos)
    @starting_pos = starting_pos
    @move_tree = TreeNode.new(@starting_pos)
    build_move_tree
  end

  def build_move_tree
    visited_positions = []
    queue = [@move_tree]

    until queue.empty?
      current_node = queue.shift
      value = current_node.value

      visited_positions << value unless visited_positions.include?(value)

      new_move_positions(value).each do |coord|
        next if visited_positions.include?(coord)
        child = TreeNode.new(coord)
        current_node.add_child(child)
        queue << child
      end
    end
  end

  def find_path(target_position)
    return nil unless (0..7).include?(target_position[0]) && (0..7).include?(target_position[1])
    target_node = @move_tree.bfs(target_position)
    target_node.path
  end

  def new_move_positions(starting_pos)
    moves = [[-2,2],[-1,1]]
    x, y = starting_pos
    possible_squares = []

    moves[0].each do |num1|
      moves[1].each do |num2|
        possible_squares << [x + num1, y + num2]
      end
    end

    moves.reverse!
    moves[0].each do |num1|
      moves[1].each do |num2|
        possible_squares << [x + num1, y + num2]
      end
    end

    #filters out all squares less than or greater than 7
    possible_squares.select! { |square| (0..7).include?(square[0]) && (0..7).include?(square[1]) }
    possible_squares
  end

  def valid_position?(pos)

  end


end

kpf = KnightPathFinder.new([0,0])
p kpf.find_path([3, 3])