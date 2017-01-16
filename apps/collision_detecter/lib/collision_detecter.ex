defmodule CollisionDetecter do
  @moduledoc ~S"""
  Detect network collisions on graph's nodes. Graph nodes need to be sorted {1,2} and not {2,1}.

  ## Examples

      iex> CollisionDetecter.detect([[1,2], [2,3], [4,5], [5,6]])
      {:ok, %{collisions: [[1, 2, 3], [4, 5, 6]], count: 2, message: "Collisions detected"}}
  """

  def detect(graph) do
    graph
    |> Enum.sort
    |> detect_graph_collision
  end

  def detect_graph_collision(graph) do
    case return_graph_collision(graph) do
      {0, _} -> {:ok, %{count: 0, message: "No collisions detected in the graph."}}
      {collisions_count, collisions} -> {:ok, %{message: "Collisions detected", count: collisions_count, collisions: collisions}}
    end
  end

  def return_graph_collision(graph) do
    graph_collisions =
      graph
      |> Enum.reduce([], fn(node, acc) -> find_and_insert_node(node, acc) end)
      |> Enum.filter(fn(subset) -> Enum.count(subset) > 2 end)

    {Enum.count(graph_collisions), graph_collisions}
  end

  def nodes_in_same_collision_network?(collisions, node_a, node_b) do
    {:ok, %{collisions: collision_networks}} = detect(collisions)
    Enum.any?(collision_networks, fn (collisions) ->
      Enum.any?(collisions, fn (node) -> node == node_a end)
      && Enum.any?(collisions, fn(node) -> node == node_b end)
    end)
  end

  def find_and_insert_node(node, acc) do
    node_match = fn (subset) -> Enum.any?(subset, fn(x) -> Enum.at(node, 0) == x || Enum.at(node,1) == x end) end
    subset =  Enum.find(acc, fn (subset) -> node_match.(subset) end)
    if subset do
      new_subset =
         subset
         |> Stream.concat(node)
         |> Enum.sort
         |> Enum.dedup

      acc
      |> List.delete(subset)
      |> Enum.into([new_subset])
      |> Enum.sort
    else
      acc
      |> Enum.into([node])
      |> Enum.sort
    end
  end
end
