defmodule Api.CollisionsService.InMemory do
  def get_collisions do
    [["1","2","3", "4"], ["5", "6", "7"]]
  end

  def write_collision(node_a, node_b) do
    collision = "#{node_a} #{node_b}"
    {:ok, collision}
  end
end
