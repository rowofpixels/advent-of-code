defmodule Fertilizer do
  alias Fertilizer.Parser

  @maps [
    :seed_to_soil,
    :soil_to_fertilizer,
    :fertilizer_to_water,
    :water_to_light,
    :light_to_temperature,
    :temperature_to_humidity,
    :humidity_to_location
  ]

  def solve(input) do
    data = Parser.parse(input)
    maps = get_maps(data)

    data
    |> Map.get(:seeds)
    |> Enum.map(&location_in_maps(&1, maps))
    |> Enum.min()
  end

  defp get_maps(data), do: Enum.map(@maps, &Map.get(data, &1))

  defp location_in_maps(seed, maps) do
    maps
    |> Enum.reduce(seed, fn ranges, source ->
      source_to_destination_from_ranges(source, ranges)
    end)
  end

  defp source_to_destination_from_ranges(source, ranges) do
    Enum.find_value(ranges, source, fn range ->
      source_to_destination_from_range(source, range)
    end)
  end

  defp source_to_destination_from_range(source, [
         destination_range_start,
         source_range_start,
         range_length
       ])
       when source >= source_range_start and source <= source_range_start + range_length,
       do: source - source_range_start + destination_range_start

  defp source_to_destination_from_range(_source, _range), do: nil
end
