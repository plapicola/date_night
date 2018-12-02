require_relative 'node'
require 'pry'

class BinarySearchTree

  def initialize
    @count = 0
    @root = nil
  end

  def insert(rating, title)
    if !include?(rating)
      new_node = Node.new(rating, title)
      @count += 1
      if @root == nil
        @root = new_node
        return 0
      else
        return insert_node(@root, new_node)
      end
    end
  end

  def insert_node(current, new_node)
    if current.rating < new_node.rating
      if current.right != nil
        # Return 1 + to capture depth
        return 1 + insert_node(current.right, new_node)
      else
        current.right = new_node
        return 1
      end
    elsif current.rating > new_node.rating
      if current.left != nil
        return 1 + insert_node(current.left, new_node)
      else
        current.left = new_node
        return 1
      end
    end
  end

  def include?(rating)
    if @root == nil
      return false
    end

    return has_node_in_tree?(@root, rating)
  end

  def has_node_in_tree? (current, rating)
    # Found score
    return true if current.rating == rating

    #
    if rating < current.rating
      if current.left != nil
        return has_node_in_tree?(current.left, rating)
      else
        return false
      end
    elsif rating > current.rating
      if current.right != nil
        return has_node_in_tree?(current.right, rating)
      else
        return false
      end
    else
      # Not found
      return false
    end
  end

  def depth_of(rating)
    if include?(rating)
      return depth_of_node(@root, rating)
    else
      return nil
    end
  end

  def depth_of_node(current, rating)
    if current.rating == rating
      return 0
    end

    if rating < current.rating
      return 1 + depth_of_node(current.left, rating)
    else
      return 1 + depth_of_node(current.right, rating)
    end
  end

  def max
    return find_max(@root) unless @root == nil
    return nil
  end

  def find_max(current)
    return find_max(current.right) unless current.left == nil
    return current.information
  end

  def min
    return find_min(@root) unless @root == nil
    return nil
  end

  def find_min(current)
    return find_min(current.left) unless current.left == nil
    return current.information
  end

  def sort
    sorted = []
    get_sorted(@root, sorted)
  end

  def get_sorted(current, collection)
    if current == nil
      return collection
    end

    get_sorted(current.left, collection)
    collection << current.information
    get_sorted(current.right, collection)
  end

  def leaves
    return count_leaves(@root)
  end

  def count_leaves(current)
    if current == nil
      return 0
    end
    if current.is_leaf?
      return 1
    end

    return count_leaves(current.left) + count_leaves(current.right)
  end

  def height
    if @root == nil
      return nil
    end

    find_height(@root)
  end

  def find_height(current)
    # Define initial values to ensure later if functions
    left_depth = 0
    right_depth = 0
    left_depth = find_height(current.left) + 1 unless current.left == nil
    right_depth = find_height(current.right) + 1 unless current.right == nil

    if left_depth > right_depth
      return left_depth
    end
    return right_depth
  end

  def load(filename)
    count_loaded = 0
    movies = IO.readlines(filename)
    movies.each do |movie|
      movie = movie.chomp #Remove newline character
      movie_info = movie.split(", ")
      insert(movie_info[0].to_i, movie_info[1])
      count_loaded += 1
    end
    return count_loaded
  end

  def delete(value) # Refactor me
    if include?(value)
      if @root.rating != value
        found_node = remove_branch(@root, value)
      else
        found_node = @root
        @root = nil
      end
      @count -= 1
      reinsert_children(found_node)
      return found_node.rating
    else
      return nil
    end
  end

  def remove_branch(current, value) # Refactor me
    if current.rating < value
      if current.right.rating == value
        temp = current.right
        current.right = nil
        return temp
      else
        return remove_branch(current.right, value)
      end
    else
      if current.left.rating == value
        temp = current.left
        current.left = nil
        return temp
      else
        return remove_branch(current.left, value)
      end
    end
  end

  def reinsert_children(current)
    data = get_array_of_children(current)
    if @root == nil && @count != 0
      generate_new_root(data)
    end
    binary_search_insert(data, 0, data.length - 1) unless data.length == 0
  end

  def get_array_of_children(deleted_node)
    left = []
    right = []
    get_sorted(deleted_node.left, left)
    get_sorted(deleted_node.right, right)
    left + right
  end

  def generate_new_root(data)
    midpoint = (0 + data.length - 1) / 2
    rating = data[midpoint].values.first
    title = data[midpoint].keys.first
    @root = Node.new(rating, title)
  end

  def binary_search_insert(data, left, right)
    return if left > right
    midpoint = (left + right) / 2
    rating = data[midpoint].values.first
    title = data[midpoint].keys.first
    insert_node(@root, Node.new(rating, title))
    binary_search_insert(data, left, midpoint - 1)
    binary_search_insert(data, midpoint + 1, right)
  end

  def health(depth)
    nodes = []
    nodes_at_depth(nodes, depth, @root, 0)
    tree_health = nodes.map do |node|
      [node.rating, node.children, (node.children * 100.0 / @count).to_i]
    end
  end

  def nodes_at_depth(nodes, depth, current_node, current_depth)
    nodes << current_node if depth == current_depth
    if current_node.left != nil
      nodes_at_depth(nodes, depth, current_node.left, current_depth + 1)
    end
    if current_node.right != nil
      nodes_at_depth(nodes, depth, current_node.right, current_depth + 1)
    end
  end



  # Would Like: Rebalance Tree Method using Reinsert Children



end
