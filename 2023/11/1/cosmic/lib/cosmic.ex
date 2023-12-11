defmodule Cosmic do
  alias Cosmic.Parser
  alias Cosmic.Utils

  def solve(input) do
    input
    |> Parser.parse()
    |> Utils.expand_universe()
    |> Utils.galaxy_coordinates()
    |> Utils.pair_coordinates()
    |> Enum.map(&distance/1)
    |> Enum.sum()
  end

  defp distance({{a_x, a_y}, {b_x, b_y}}), do: abs(b_y - a_y) + abs(b_x - a_x)
end
