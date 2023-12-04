defmodule Scratchcards do
  alias Scratchcards.Parser
  alias Scratchcards.Utils

  def solve(input) do
    input
    |> Utils.clean_stream()
    |> Stream.map(&Parser.parse/1)
    |> Stream.with_index()
    |> Enum.reduce(%{count: 0, copies_by_index: []}, &count_cards/2)
    |> Map.get(:count)
  end

  defp count_cards({game, index}, %{count: count, copies_by_index: copies_by_index}) do
    card_count = 1

    %{true => copies, false => copies_by_index} =
      copies_by_index
      |> Enum.group_by(&(index == &1))
      |> Map.put_new(true, [])
      |> Map.put_new(false, [])

    card_count = card_count + length(copies)

    win_count = count_wins(game)

    new_copies =
      index..(index + win_count)
      |> Enum.to_list()
      |> List.delete(index)
      |> List.duplicate(card_count)
      |> List.flatten()

    copies_by_index = copies_by_index ++ new_copies

    %{
      count: count + card_count,
      copies_by_index: copies_by_index
    }
  end

  defp count_wins(%{winning: winning, owned: owned}) do
    MapSet.new(winning)
    |> MapSet.intersection(MapSet.new(owned))
    |> MapSet.to_list()
    |> length()
  end
end
