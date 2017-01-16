defmodule Api.NetworkCollisionController do
  use Api.Web, :controller
  @collisions_service Application.get_env(:api, :collisions_service)

  def index(conn, _params) do
    collisions = @collisions_service.get_collisions
    collisions_result = CollisionDetecter.detect(collisions)
    render conn, "index.json", collisions_result: collisions_result
  end

  def show(conn, %{"node_a" => node_a, "node_b" => node_b}) do
    collisions = @collisions_service.get_collisions
    same_collision_network = CollisionDetecter.nodes_in_same_collision_network?(collisions, node_a, node_b)

    render conn, "show.json", result: same_collision_network
  end

  def create(conn, %{"node_a" => node_a, "node_b" => node_b}) do
    {:ok, collision} = @collisions_service.write_collision(node_a, node_b)
    render conn, "post.json", collision: collision
  end
end
