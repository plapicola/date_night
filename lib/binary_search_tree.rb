require_relative 'node'

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
    if current.rating == rating
      return true
    end

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


end
