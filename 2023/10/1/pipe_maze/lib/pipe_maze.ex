defmodule PipeMaze do
  alias PipeMaze.Parser
  alias PipeMaze.Utils

  def solve(input) do
    map = Parser.parse(input)
    start_coordinates = Utils.find_coordinates(map, :start)

    map
    |> Utils.build_loop(start_coordinates)
    |> length()
    |> Integer.floor_div(2)
  end
end
