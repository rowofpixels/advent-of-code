defmodule Scratchcards.Parser do
  import NimbleParsec

  label =
    string("Card")
    |> repeat(string(" "))
    |> concat(integer(min: 1))
    |> concat(string(":"))
    |> ignore()

  winning_numbers =
    repeat(
      repeat(string(" "))
      |> ignore()
      |> integer(min: 1)
    )
    |> tag(:winning)

  separator =
    string(" ")
    |> string("|")
    |> string(" ")
    |> ignore()

  owned_numbers =
    repeat(
      repeat(string(" "))
      |> ignore()
      |> integer(min: 1)
    )
    |> tag(:owned)

  defparsec(
    :do_parse,
    label
    |> concat(winning_numbers)
    |> concat(separator)
    |> concat(owned_numbers)
  )

  def parse(input) do
    case do_parse(input) do
      {:ok, result, "", _, _, _} ->
        format_result(result)
    end
  end

  defp format_result(result), do: Enum.into(result, %{})
end
