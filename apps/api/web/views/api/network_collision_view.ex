defmodule Api.NetworkCollisionView do
  use Api.Web, :view

  def render("index.json", %{collisions_result: collisions_result}) do
    %{
      collision_result: collisions_result_json(collisions_result)
    }
  end

  def render("post.json", %{collision: collision}) do
    %{
     "message" => "Collision added: #{collision}"
    }
  end

  def render("show.json", %{result: result}) do
    %{
      "inSameCollisionNetwork" => result
    }
  end

  defp collisions_result_json(collisions_result) do
    {:ok, result} = collisions_result
    %{
      "message" =>  result.message,
      "count" => result.count,
      "collisions" => result.collisions
    }
  end
end
