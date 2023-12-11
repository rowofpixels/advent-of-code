defmodule Cosmic.Parser do
  import NimbleParsec

  line =
    repeat(
      choice([
        string("."),
        string("#")
      ])
    )
    |> concat(string("\n") |> ignore())
    |> tag(:line)

  lines = repeat(line)

  defparsec(
    :do_parse,
    empty()
    |> concat(lines)
  )

  def parse(input) do
    case do_parse(input) do
      {:ok, result, "", _, _, _} ->
        result
        |> Enum.map(fn {:line, line} ->
          line
          |> Enum.map(fn
            "." ->
              nil

            "#" ->
              :galaxy
          end)
        end)
    end
  end
end
