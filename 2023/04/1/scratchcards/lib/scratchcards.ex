defmodule Scratchcards do
  alias Scratchcards.Parser
  alias Scratchcards.Utils

  def solve(input) do
    input
    |> Utils.clean_stream()
    |> Stream.map(&Parser.parse/1)
    |> Stream.map(&to_score/1)
    |> Enum.sum()
  end

  defp to_score(result) do
    result
    |> count_wins()
    |> calculate_score()
  end

  defp count_wins(%{winning: winning, owned: owned}) do
    MapSet.new(winning)
    |> MapSet.intersection(MapSet.new(owned))
    |> MapSet.to_list()
    |> length()
  end

  defp calculate_score(0), do: 0
  defp calculate_score(value), do: 2 ** (value - 1)
end
