defmodule Mirage.Parser do
  import NimbleParsec

  numbers =
    repeat(
      optional(string("-"))
      |> integer(min: 1)
      |> concat(optional(string(" ")) |> ignore())
      |> tag(:number)
    )

  defparsec(
    :do_parse,
    empty()
    |> concat(numbers)
  )

  def parse(input) do
    case do_parse(input) do
      {:ok, result, "", _, _, _} ->
        result
        |> Enum.reduce([], fn
          {:number, ["-", value]}, acc ->
            acc ++ [-1 * value]

          {:number, [value]}, acc ->
            acc ++ [value]
        end)
    end
  end
end
