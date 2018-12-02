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
    else current.rating > new_node.rating
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
    if @root == 0
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

  def delete(value)
    if include?(value)
      if @root.rating != value
        found_node = remove_branch(@root, value)
      else
        found_node = @root
        @root = nil
      end
      reinsert_children(found_node)
      @count -= 1
      return found_node.rating
    else
      return nil
    end
  end

  def remove_branch(current, value)
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
    insert_node(@root, current.left) unless current.left == nil
    insert_node(@root, current.right) unless current.right == nil

    if current.left != nil && current.right != nil
      if current.right.children > current.left.children
        reinsert_children(current.right)
        reinsert_children(current.left)
      else
        reinsert_children(current.left)
        reinsert_children(current.right)
      end
    elsif current.right != nil
      reinsert_children(current.right)
    elsif current.left != nil
      reinsert_children(current.left)
    end
  end


  #   # if current == nil || current.value == value
  #   #   return current
  #   # end
  #
  #   # if current.value > value
  #   #   return find_node(current.left, value)
  #   # end
  #   # return find_node(current.right, value)
  # end


end
