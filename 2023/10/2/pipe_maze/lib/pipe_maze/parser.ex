defmodule PipeMaze.Parser do
  import NimbleParsec

  newline =
    string("\n")
    |> ignore()

  line =
    empty()
    |> repeat(
      choice([
        string("|"),
        string("-"),
        string("L"),
        string("J"),
        string("7"),
        string("F"),
        string("."),
        string("S")
      ])
    )
    |> concat(newline)
    |> tag(:line)

  lines = repeat(line)

  defparsec(
    :do_parse,
    empty()
    |> concat(lines)
    |> eos()
  )

  def parse(input) do
    case do_parse(input) do
      {:ok, result, "", _, _, _} ->
        Enum.map(result, &map_line/1)
    end
  end

  defp map_line({:line, values}), do: Enum.map(values, &map_value/1)
  defp map_value("|"), do: :vertical
  defp map_value("-"), do: :horizontal
  defp map_value("L"), do: :north_east
  defp map_value("J"), do: :north_west
  defp map_value("7"), do: :south_west
  defp map_value("F"), do: :south_east
  defp map_value("."), do: :ground
  defp map_value("S"), do: :start
end
