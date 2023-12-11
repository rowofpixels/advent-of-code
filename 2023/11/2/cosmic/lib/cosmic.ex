defmodule Cosmic do
  alias Cosmic.Parser
  alias Cosmic.Utils

  def solve(input, expansion_distance \\ 1_000_000) do
    universe = Parser.parse(input)
    {empty_x, empty_y} = Utils.get_empty_x_and_y(universe)

    pairs =
      universe
      |> Utils.galaxy_coordinates()
      |> Utils.pair_coordinates()

    pairs
    |> Enum.map(&shift_coordinates(&1, empty_x, empty_y, expansion_distance))
    |> Enum.map(&distance/1)
    |> Enum.sum()
  end

  defp shift_coordinates({{a_x, a_y}, {b_x, b_y}}, empty_x, empty_y, expansion_distance) do
    a_x = a_x + length(Enum.filter(empty_x, &(&1 < a_x))) * (expansion_distance - 1)
    a_y = a_y + length(Enum.filter(empty_y, &(&1 < a_y))) * (expansion_distance - 1)
    b_x = b_x + length(Enum.filter(empty_x, &(&1 < b_x))) * (expansion_distance - 1)
    b_y = b_y + length(Enum.filter(empty_y, &(&1 < b_y))) * (expansion_distance - 1)

    {
      {a_x, a_y},
      {b_x, b_y}
    }
  end

  defp distance({{a_x, a_y}, {b_x, b_y}}), do: abs(b_y - a_y) + abs(b_x - a_x)
end
