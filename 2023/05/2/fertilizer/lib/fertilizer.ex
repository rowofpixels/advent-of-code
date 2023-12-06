defmodule Fertilizer do
  alias Fertilizer.Parser
  alias Fertilizer.Utils

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

    maps =
      data
      |> get_maps()
      |> Enum.map(&ranges_to_tuples/1)

    seeds =
      data.seeds
      |> Enum.chunk_every(2)
      |> Enum.map(fn [seed_start, seed_length] ->
        {seed_start, nil, seed_length}
      end)

    data = [seeds] ++ maps

    data
    |> evaluate()
    |> Enum.map(&elem(&1, 0))
    |> Enum.min()
  end

  defp get_maps(data), do: Enum.map(@maps, &Map.get(data, &1))

  defp evaluate([last]), do: last

  defp evaluate([head | tail]) do
    {next, tail} = List.pop_at(tail, 0)
    # IO.inspect(head, label: "head", limit: :infinity, charlists: :as_lists)
    # IO.inspect(next, label: "next", limit: :infinity, charlists: :as_lists)
    # IO.inspect(tail, label: "tail", limit: :infinity, charlists: :as_lists)

    next_head = Utils.expand_ranges_from_destination_to_source(head, next)

    # IO.inspect(next_head, label: "next head", limit: :infinity, charlists: :as_lists)

    evaluate([next_head | tail])
  end

  defp ranges_to_tuples(ranges), do: Enum.map(ranges, &range_to_tuple/1)
  defp range_to_tuple([destination, source, length]), do: {destination, source, length}
end
