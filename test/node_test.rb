require_relative 'test_helper'

class NodeTest < Minitest::Test

  def test_it_exists
    node = Node.new(10)

    assert_instance_of Node, node
  end

  def test_it_holds_a_value
    node = Node.new(10)

    assert_equal 10, node.value
  end

  def test_it_has_a_left_reference
    node = Node.new(10)
    left_node = Node.new(8)

    node.left = left_node
    assert_equal left_node, node.left
  end

  def test_it_has_a_right_reference
    node = Node.new(10)
    right_node = Node.new(13)

    node.right = right_node
    assert_equal right_node, node.right
  end

end
