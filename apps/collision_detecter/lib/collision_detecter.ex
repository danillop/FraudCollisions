defmodule CollisionDetecter do
  def detect(graph) do
    graph
    |> Enum.sort
    |> detect_graph_collision
  end

  def detect_graph_collision(graph) do
    graph
    |> Enum.reduce([], fn(node, acc) -> find_and_insert_node(node, acc) end)
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
