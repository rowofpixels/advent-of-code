defmodule Wait.Parser do
  import NimbleParsec

  time_line =
    string("Time:")
    |> ignore()
    |> repeat(string(" ") |> ignore())
    |> repeat(integer(min: 1) |> times(string(" ") |> ignore(), min: 1))
    |> integer(min: 1)
    |> tag(:times)
    |> concat(string("\n") |> ignore())

  distance_line =
    string("Distance:")
    |> ignore()
    |> repeat(string(" ") |> ignore())
    |> repeat(integer(min: 1) |> times(string(" ") |> ignore(), min: 1))
    |> integer(min: 1)
    |> tag(:distances)
    |> concat(string("\n") |> ignore())

  defparsec(
    :do_parse,
    time_line
    |> concat(distance_line)
  )

  def parse(input) do
    case do_parse(input) do
      {:ok, [times: times, distances: distances], "", _, _, _} ->
        Enum.zip(times, distances)
    end
  end
end
