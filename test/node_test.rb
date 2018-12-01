require_relative 'test_helper'

class NodeTest < Minitest::Test

  def test_it_exists
    node = Node.new(10, "Test")

    assert_instance_of Node, node
  end

  def test_it_holds_a_rating_and_title
    node = Node.new(10, "Test")

    assert_equal 10, node.rating
    assert_equal "Test", node.title
  end

  def test_it_has_a_left_reference
    node = Node.new(10, "Test")
    left_node = Node.new(8, "Left")
    node.left = left_node

    node.left = left_node
    assert_equal left_node, node.left
  end

  def test_it_has_a_right_reference
    node = Node.new(10, "Test")
    right_node = Node.new(13, "Right")
    node.right = right_node

    node.right = right_node
    assert_equal right_node, node.right
  end

  def test_it_tracks_children
    node = Node.new(10, "Test")
    left_node = Node.new(8, "Left")
    node.left = left_node

    assert_equal 2, node.children
  end

end
