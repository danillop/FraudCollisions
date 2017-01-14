defmodule Api.CollisionsService.FileImportService do
  def get_collisions do
    "media/collisions.txt"
    |> File.stream!
    |> Stream.map(&String.strip/1)
    |> Stream.map(&String.split/1)
    |> Stream.map(&Enum.sort/1)
    |> Enum.to_list
  end
end
