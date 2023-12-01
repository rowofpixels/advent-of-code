defmodule CampCleanup do
  def count_contained_ranges(data) do
    data
    |> clean()
    |> Stream.map(&parse_ranges/1)
    |> Stream.filter(&ranges_contain?/1)
    |> Enum.count()
  end

  def count_overlap_ranges(data) do
    data
    |> clean()
    |> Stream.map(&parse_ranges/1)
    |> Stream.filter(&ranges_overlap?/1)
    |> Enum.count()
  end

  defp clean(data) do
    data
    |> Stream.map(&String.trim/1)
    |> Stream.filter(&(&1 != ""))
  end

  defp parse_ranges(data) do
    [first, second] = String.split(data, ",")
    [first_start, first_end] = String.split(first, "-")
    [second_start, second_end] = String.split(second, "-")
    first_start = String.to_integer(first_start)
    first_end = String.to_integer(first_end)
    second_start = String.to_integer(second_start)
    second_end = String.to_integer(second_end)

    {
      {first_start, first_end},
      {second_start, second_end}
    }
  end

  defp ranges_contain?({first, second}),
    do: range_contains?(first, second) or range_contains?(second, first)

  defp range_contains?({first_start, first_end}, {second_start, second_end})
       when first_start <= second_start and first_end >= second_end,
       do: true

  defp range_contains?(_, _), do: false

  defp ranges_overlap?({first, second}),
    do: range_overlaps?(first, second) or range_overlaps?(second, first)

  defp range_overlaps?({first_start, _first_end}, {second_start, second_end})
       when first_start >= second_start and first_start <= second_end,
       do: true

  defp range_overlaps?({_first_start, first_end}, {second_start, second_end})
       when first_end >= second_start and first_end <= second_end,
       do: true

  defp range_overlaps?(_, _), do: false
end
