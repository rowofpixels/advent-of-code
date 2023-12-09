defmodule HauntedWasteland.Parser do
  import NimbleParsec

  directions =
    repeat(
      choice([
        string("L"),
        string("R")
      ])
    )
    |> tag(:directions)
    |> concat(string("\n") |> ignore())

  mappings =
    repeat(
      ascii_string([?A..?Z] ++ [?0..?9], 3)
      |> concat(string(" = (") |> ignore())
      |> ascii_string([?A..?Z] ++ [?0..?9], 3)
      |> concat(string(", ") |> ignore())
      |> ascii_string([?A..?Z] ++ [?0..?9], 3)
      |> concat(string(")\n") |> ignore())
      |> wrap()
    )
    |> tag(:mappings)

  defparsec(
    :do_parse,
    directions
    |> concat(string("\n") |> ignore())
    |> concat(mappings)
  )

  def parse(input) do
    case do_parse(input) do
      {:ok, [directions: directions, mappings: mappings], "", _, _, _} ->
        {format_directions(directions), format_mappings(mappings)}
    end
  end

  defp format_directions(directions), do: Enum.map(directions, &format_direction/1)
  defp format_direction("L"), do: :left
  defp format_direction("R"), do: :right

  defp format_mappings(mappings), do: mappings |> Enum.map(&format_mapping/1) |> Enum.into(%{})
  defp format_mapping([key, left, right]), do: {key, {left, right}}
end
