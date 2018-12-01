require_relative 'test_helper'

class BinarySearchTreeTest < Minitest::Test

    def test_it_exists
      tree = BinarySearchTree.new

      assert_instance_of BinarySearchTree, tree
    end

    def test_it_can_add_new_elements_and_depth_is_returned
      skip
      tree = BinarySearchTree.new
      depth = tree.insert(61, "Bill & Ted's Excellent Adventure")

      assert tree.include?(61)
      assert_equal 0, depth
    end

    def test_it_can_determine_if_item_is_present
      tree = BinarySearchTree.new
      depth = tree.insert(61, "Bill & Ted's Excellent Adventure")

      assert tree.include?(61)
      refute tree.include?(42)
    end

    def test_it_can_determine_depth
      tree = BinarySearchTree.new
      tree.insert(61, "Bill & Ted's Excellent Adventure")
      tree.insert(16, "Johnny English")
      tree.insert(50, "Hannibal Buress: Animal Furnace")


      assert_equal 0, tree.depth_of(61)
      assert_equal 1, tree.depth_of(16)
      assert_equal 2, tree.depth_of(50)
    end

    def test_it_can_determine_max_rated
      tree = BinarySearchTree.new
      tree.insert(61, "Bill & Ted's Excellent Adventure")
      tree.insert(16, "Johnny English")
      tree.insert(92, "Sharknado 3")
      tree.insert(50, "Hannibal Buress: Animal Furnace")

      expected = {"Sharknado 3"=>92}

      assert_equal expected, tree.max
    end

    def test_it_can_determine_lowest_rated
      tree = BinarySearchTree.new
      tree.insert(61, "Bill & Ted's Excellent Adventure")
      tree.insert(16, "Johnny English")
      tree.insert(92, "Sharknado 3")
      tree.insert(50, "Hannibal Buress: Animal Furnace")

      expected = {"Johnny English" => 16}

      assert_equal expected, tree.min
    end

    def test_it_can_sort_movies
      tree = BinarySearchTree.new
      tree.insert(61, "Bill & Ted's Excellent Adventure")
      tree.insert(16, "Johnny English")
      tree.insert(92, "Sharknado 3")
      tree.insert(50, "Hannibal Buress: Animal Furnace")

      expected = [{"Johnny English"=> 16},
                  {"Hannibal Buress: Animal Furnace"=> 50},
                  {"Bill & Ted's Excellent Adventure"=> 61},
                  {"Sharknado 3"=> 92}]

      assert_equal expected, tree.sort
    end

    def test_it_can_count_leaves
      tree = BinarySearchTree.new
      tree.insert(98, "Animals United")
      tree.insert(58, "Armageddon")
      tree.insert(36, "Bill & Ted's Bogus Journey")
      tree.insert(93, "Bill & Ted's Excellent Adventure")
      tree.insert(86, "Charlie's Angels")
      tree.insert(38, "Charlie's Country")
      tree.insert(69, "Collateral Damage")

      assert_equal tree.leaves, 2
    end

    def test_it_has_a_height
      tree = BinarySearchTree.new
      tree.insert(98, "Animals United")
      tree.insert(58, "Armageddon")
      tree.insert(36, "Bill & Ted's Bogus Journey")
      tree.insert(93, "Bill & Ted's Excellent Adventure")
      tree.insert(86, "Charlie's Angels")
      tree.insert(38, "Charlie's Country")
      tree.insert(69, "Collateral Damage")

      assert_equal tree.height, 4
    end

    def test_it_can_load_movies_from_file
      skip
      tree = BinarySearchTree.new
      count = tree.load 'movies.txt'

      assert_equal count, 100
    end
    def test_it_can_delete
      skip
      tree = BinarySearchTree.new
      tree.insert(98, "Animals United")
      tree.insert(58, "Armageddon")
      tree.insert(36, "Bill & Ted's Bogus Journey")
      tree.insert(93, "Bill & Ted's Excellent Adventure")
      tree.insert(86, "Charlie's Angels")
      tree.insert(38, "Charlie's Country")
      tree.insert(69, "Collateral Damage")

      assert tree.include?(86)
      tree.delete(86)
      refute tree.include?(86)
      assert tree.include(58)
    end

    def test_it_can_determine_health
      skip
      tree = BinarySearchTree.new
      tree.insert(98, "Animals United")
      tree.insert(58, "Armageddon")
      tree.insert(36, "Bill & Ted's Bogus Journey")
      tree.insert(93, "Bill & Ted's Excellent Adventure")
      tree.insert(86, "Charlie's Angels")
      tree.insert(38, "Charlie's Country")
      tree.insert(69, "Collateral Damage")

      expected_at_depth_0 = [[98, 7, 100]]

      expected_at_depth_2 = [[36, 2, (2.to_f / 7 * 100).to_i]]
      expected_at_depth_2 << [93, 3, (3.to_f / 7 * 100).to_i]

      assert_equal expected_at_depth_2, tree.health(2)
    end

end
