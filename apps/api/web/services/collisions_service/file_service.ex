defmodule Api.CollisionsService.FileService do
  def get_collisions do
    "media/collisions.txt"
    |> File.stream!
    |> Stream.map(&String.strip/1)
    |> Stream.map(&String.split/1)
    |> Stream.map(&Enum.sort/1)
    |> Enum.to_list
  end

  def write_collision(node_a, node_b) do
    {:ok, file} = File.open("media/collisions.txt", [:append])
    IO.binwrite(file, "#{node_a} #{node_b}" <> "\n")
    File.close(file)
  end
end
