defmodule Api.NetworkCollisionTest do
  use Api.ConnCase

  test "return network collision results", %{conn: conn} do
    conn = get conn, network_collision_path(conn, :index)
    assert json_response(conn, 200) == %{
     "collision_result" => %{
       "message" => "Collisions detected",
       "count" => 2,
       "collisions" => [["1","2","3", "4"], ["5", "6", "7"]]
     }
    }
  end

  test "add new collisions between two nodes", %{conn: conn} do
    conn = post conn, network_collision_path(conn, :create, node_a: "a", node_b: "b")
    assert json_response(conn,  200) == %{
      "message" => "Collision added: a b"
    }
  end

  test "check collision between two nodes - expects to receive TRUE", %{conn: conn} do
    conn = get conn, network_collision_path(conn, :show, 1, 4)
    assert json_response(conn, 200) == %{
     "inSameCollisionNetwork" => true
    }
  end

  test "check collision between two nodes - expects to receive FALSE", %{conn: conn} do
    conn = get conn, network_collision_path(conn, :show, 1, 9)
    assert json_response(conn, 200) == %{
      "inSameCollisionNetwork" => false
    }
  end
end
