defmodule GearRatios.Parser do
  import NimbleParsec

  id =
    string("Game ")
    |> ignore()
    |> concat(integer(min: 1))
    |> concat(string(":") |> ignore())
    |> unwrap_and_tag(:id)

  color =
    integer(min: 1)
    |> unwrap_and_tag(:count)
    |> concat(string(" ") |> ignore())
    |> concat(
      choice([
        string("red"),
        string("green"),
        string("blue")
      ])
      |> unwrap_and_tag(:color)
    )

  hand =
    times(
      string(" ")
      |> ignore()
      |> concat(color)
      |> concat(optional(string(",")) |> ignore()),
      min: 1
    )
    |> tag(:hand)

  hands =
    repeat(
      times(hand, min: 1)
      |> concat(optional(string(";")) |> ignore())
    )
    |> tag(:hands)

  defparsec(
    :do_parse,
    id
    |> concat(hands)
  )

  def parse(input) do
    case do_parse(input) do
      {:ok, result, "", _, _, _} ->
        format_result(result)

      :error ->
        :error
    end
  end

  defp format_result(id: id, hands: hands),
    do: %{
      id: id,
      hands: format_hands(hands)
    }

  defp format_hands(hands) do
    hands
    |> Keyword.get_values(:hand)
    |> Enum.map(&format_hand/1)
  end

  defp format_hand(hand) do
    hand
    |> Enum.chunk_every(2)
    |> Enum.map(fn [count: count, color: color] ->
      {color, count}
    end)
    |> Enum.into(%{})
  end
end
