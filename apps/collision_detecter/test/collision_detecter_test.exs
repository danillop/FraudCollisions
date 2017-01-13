defmodule CollisionDetecterTest do
  use ExUnit.Case
  doctest CollisionDetecter

  test "return network collisions" do
    graph = [[1,2], [2,3], [1,4], [5,6], [6, 7]]
    assert CollisionDetecter.detect(graph) ==  [[1, 2, 3, 4], [5, 6, 7]]
  end

  test ".find_and_insert_node - doesnt find an existing node so insert a new one" do
    node = [1,2]
    acc = []
    assert CollisionDetecter.find_and_insert_node(node, acc) == [[1,2]]
  end

  test ".find_and_insert_node - find an existing node and then merge the nodes" do
    node = [2,3]
    acc = [[1,2]]
    assert CollisionDetecter.find_and_insert_node(node, acc) == [[1,2,3]]
  end

  test ".find_and_insert_node - find an existing three items node and then merge the nodes" do
    acc = [[1,2]]
    node = [2,3]
    acc = CollisionDetecter.find_and_insert_node(node, acc)

    node = [1,4]
    assert CollisionDetecter.find_and_insert_node(node, acc) == [[1,2,3,4]]
  end
end
