defmodule Api.NetworkCollisionTest do
  use Api.ConnCase

  test "return network collision results", %{conn: conn} do
    conn = get conn, network_collision_path(conn, :index)
    assert json_response(conn, 200) == %{
     "collision_result" => %{
       "message" => "Collisions detected",
       "count" => 2,
       "collisions" => [[1, 2, 3, 4], [5, 6, 7]]
     }
    }
  end
end
