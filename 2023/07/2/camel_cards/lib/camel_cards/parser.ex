defmodule CamelCards.Parser do
  import NimbleParsec

  hand =
    times(
      ascii_char([?A, ?K, ?Q, ?J, ?T, ?9, ?8, ?7, ?6, ?5, ?4, ?3, ?2]),
      5
    )
    |> tag(:hand)

  bid =
    integer(min: 1)
    |> unwrap_and_tag(:bid)

  defparsec(
    :do_parse,
    hand
    |> concat(string(" ") |> ignore())
    |> concat(bid)
  )

  def parse(input) do
    case do_parse(input) do
      {:ok, [hand: [a, b, c, d, e], bid: bid], "", _, _, _} ->
        {{a, b, c, d, e}, bid}
    end
  end
end
