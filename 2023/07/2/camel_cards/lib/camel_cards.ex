defmodule CamelCards do
  alias CamelCards.Utils
  alias CamelCards.Parser

  def solve(input) do
    input
    |> Utils.clean_stream()
    |> Enum.map(&Parser.parse/1)
    |> Enum.sort_by(&mapper/1, :asc)
    |> Enum.map(&bid/1)
    |> Enum.with_index()
    |> Enum.map(&with_rank/1)
    |> Enum.map(&winnings/1)
    |> Enum.sum()
  end

  defp bid({_hand, bid}), do: bid

  defp with_rank({bid, index}), do: {bid, index + 1}
  defp winnings({bid, rank}), do: bid * rank

  defp mapper({hand, _bid}), do: {Utils.hand_type_value(hand), Utils.hand_value(hand)}
end
