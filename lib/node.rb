class Node

  attr_accessor :title,
                :rating,
                :left,
                :right

  def initialize(rating, title)
    @rating = rating
    @title = title
    @left = nil
    @right = nil
  end

  def children
    children = 1
    if @left != nil
      children += @left.children
    end
    if @right != nil
      children += @right.children
    end
    return children
  end
end
