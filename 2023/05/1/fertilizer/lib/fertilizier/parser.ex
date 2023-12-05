defmodule Fertilizer.Parser do
  import NimbleParsec

  ranges =
    repeat(
      times(integer(min: 1) |> concat(string(" ") |> optional() |> ignore()), 3)
      |> wrap()
      |> concat(string("\n") |> ignore())
    )

  parser =
    string("seeds: ")
    |> ignore()
    |> repeat(
      integer(min: 1)
      |> concat(
        string(" ")
        |> optional()
        |> ignore()
      )
    )
    |> concat(
      repeat(string("\n"))
      |> ignore()
    )
    |> tag(:seeds)
    |> concat(
      string("seed-to-soil map:\n")
      |> ignore()
      |> concat(ranges)
      |> concat(string("\n") |> ignore())
      |> tag(:seed_to_soil)
    )
    |> concat(
      string("soil-to-fertilizer map:\n")
      |> ignore()
      |> concat(ranges)
      |> concat(string("\n") |> ignore())
      |> tag(:soil_to_fertilizer)
    )
    |> concat(
      string("fertilizer-to-water map:\n")
      |> ignore()
      |> concat(ranges)
      |> concat(string("\n") |> ignore())
      |> tag(:fertilizer_to_water)
    )
    |> concat(
      string("water-to-light map:\n")
      |> ignore()
      |> concat(ranges)
      |> concat(string("\n") |> ignore())
      |> tag(:water_to_light)
    )
    |> concat(
      string("light-to-temperature map:\n")
      |> ignore()
      |> concat(ranges)
      |> concat(string("\n") |> ignore())
      |> tag(:light_to_temperature)
    )
    |> concat(
      string("temperature-to-humidity map:\n")
      |> ignore()
      |> concat(ranges)
      |> concat(string("\n") |> ignore())
      |> tag(:temperature_to_humidity)
    )
    |> concat(
      string("humidity-to-location map:\n")
      |> ignore()
      |> concat(ranges)
      |> tag(:humidity_to_location)
    )

  defparsec(:do_parse, parser)

  def parse(input) do
    case do_parse(input) do
      {:ok, result, "", _, _, _} ->
        Enum.into(result, %{})
    end
  end
end
