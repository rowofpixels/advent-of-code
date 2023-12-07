defmodule CamelCards do
  alias CamelCards.Utils
  alias CamelCards.Parser

  def solve(input) do
    input
    |> Utils.clean_stream()
    |> Enum.map(&Parser.parse/1)
    |> Enum.sort_by(&hand/1, &Utils.hand_sorter/2)
    |> Enum.reverse()
    |> Enum.map(&bid/1)
    |> Enum.with_index()
    |> Enum.map(&with_rank/1)
    |> Enum.map(&winnings/1)
    |> Enum.sum()
  end

  defp hand({hand, _bid}), do: hand
  defp bid({_hand, bid}), do: bid

  defp with_rank({bid, index}), do: {bid, index + 1}
  defp winnings({bid, rank}), do: bid * rank
end
