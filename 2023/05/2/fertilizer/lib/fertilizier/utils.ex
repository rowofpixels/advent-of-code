defmodule Fertilizer.Utils do
  def expand_ranges_from_destination_to_source(a, b) do
    b = Enum.sort_by(b, &source_field/1)

    b = [:start] ++ b ++ [:end]

    Enum.flat_map(a, fn a ->
      transform_ranges([a], b, [])
      |> Enum.uniq()
    end)
  end

  defp transform_ranges(
         [{head_destination, _head_source, head_length} = head | tail],
         reference_ranges,
         transformed_ranges
       ) do
    reference_ranges =
      reference_ranges
      |> Enum.reject(fn range ->
        cond do
          range == :start ->
            false

          range == :end ->
            false

          range == nil ->
            false

          true ->
            {_reference_destination, reference_source, reference_length} = range

            head_destination > reference_source + reference_length ||
              head_destination + head_length < reference_source
        end
      end)

    new_transformed_ranges =
      reference_ranges
      |> Enum.chunk_every(2, 1)
      |> Enum.drop(-1)
      |> do_stuff(head, [])

    transform_ranges(tail, reference_ranges, transformed_ranges ++ new_transformed_ranges)
  end

  defp transform_ranges([], _reference_ranges, transformed_ranges), do: transformed_ranges

  defp do_stuff(
         [[:start, :end]],
         head,
         transformed_ranges
       ) do
    transformed_ranges = transformed_ranges ++ [head]

    do_stuff([], head, transformed_ranges)
  end

  defp do_stuff(
         [[:start, {_current_destination, current_source, _current_length}] | tail],
         {head_destination, nil, _head_length} = head,
         transformed_ranges
       ) do
    transformed_ranges =
      transformed_ranges ++
        if head_destination < current_source do
          [
            {head_destination, nil, current_source - head_destination}
          ]
        else
          []
        end

    do_stuff(tail, head, transformed_ranges)
  end

  defp do_stuff(
         [[{previous_destination, previous_source, previous_length}, :end] | tail],
         {head_destination, nil, head_length} = head,
         transformed_ranges
       ) do
    transformed_ranges =
      transformed_ranges ++
        [
          {
            previous_destination - previous_source + head_destination +
              used_length(transformed_ranges),
            nil,
            min(
              remaining_length(transformed_ranges, head_length),
              min(previous_source + previous_length - head_destination, previous_length)
            )
          }
        ]

    transformed_ranges =
      transformed_ranges ++
        if remaining_length(transformed_ranges, head_length) > 0 do
          [
            {head_destination + used_length(transformed_ranges), nil,
             remaining_length(transformed_ranges, head_length)}
          ]
        else
          []
        end

    do_stuff(tail, head, transformed_ranges)
  end

  defp do_stuff(
         [
           [
             {current_destination, current_source, current_length},
             {_next_destination, next_source, _next_length}
           ]
           | tail
         ],
         {head_destination, _head_source, head_length} = head,
         transformed_ranges
       ) do
    transformed_ranges =
      transformed_ranges ++
        [
          {
            current_destination - current_source + head_destination +
              used_length(transformed_ranges),
            nil,
            min(
              remaining_length(transformed_ranges, head_length),
              min(current_source + current_length - head_destination, current_length)
            )
          }
        ]

    {_last_destination, _last_source, last_length} = List.last(transformed_ranges)

    transformed_ranges =
      transformed_ranges ++
        cond do
          head_destination + last_length == next_source ->
            []

          head_destination < next_source ->
            length = next_source - current_source

            [
              {head_destination + last_length, nil, length}
            ]

          true ->
            []
        end

    do_stuff(tail, head, transformed_ranges)
  end

  defp do_stuff([], _head, transformed_ranges), do: transformed_ranges

  defp used_length(ranges), do: Enum.sum(Enum.map(ranges, &elem(&1, 2)))
  defp remaining_length(ranges, total), do: total - used_length(ranges)

  defp source_field({_destination, source, _length}), do: source
end
