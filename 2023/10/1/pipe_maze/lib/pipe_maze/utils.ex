defmodule PipeMaze.Utils do
  def find_coordinates(map, value) do
    map
    |> Enum.with_index()
    |> Enum.reduce_while(map, fn {row, row_index}, _acc ->
      row
      |> Enum.find_index(fn item ->
        item == value
      end)
      |> case do
        nil ->
          {:cont, nil}

        col_index ->
          {:halt, {col_index, row_index}}
      end
    end)
  end

  def build_loop(map, current) do
    next =
      current
      |> surrounding_coordinates()
      |> Enum.find_value(fn coordinates ->
        case options_for_coordinates(map, coordinates) do
          [^current, _next] ->
            coordinates

          [_next, ^current] ->
            coordinates

          _none ->
            nil
        end
      end)

    _build_loop(map, current, next, [])
  end

  defp surrounding_coordinates({x, y}),
    do: [
      {x - 1, y - 1},
      {x - 1, y},
      {x - 1, y + 1},
      {x, y - 1},
      {x, y + 1},
      {x + 1, y - 1},
      {x + 1, y},
      {x + 1, y + 1}
    ]

  defp _build_loop(_map, current, next, [head | _tail] = steps) when next == head,
    do: steps ++ [current]

  defp _build_loop(map, current, next, steps) do
    case options_for_coordinates(map, next) do
      [^current, next_next] ->
        _build_loop(map, next, next_next, steps ++ [current])

      [next_next, ^current] ->
        _build_loop(map, next, next_next, steps ++ [current])
    end
  end

  defp options_for_coordinates(map, {x, y}) do
    map
    |> Enum.at(y)
    |> Enum.at(x)
    |> options_for_value({x, y})
  end

  defp options_for_value(:horizontal, {x, y}), do: [{x - 1, y}, {x + 1, y}]
  defp options_for_value(:vertical, {x, y}), do: [{x, y - 1}, {x, y + 1}]
  defp options_for_value(:ground, {_x, _y}), do: []
  defp options_for_value(:north_east, {x, y}), do: [{x, y - 1}, {x + 1, y}]
  defp options_for_value(:north_west, {x, y}), do: [{x, y - 1}, {x - 1, y}]
  defp options_for_value(:south_west, {x, y}), do: [{x, y + 1}, {x - 1, y}]
  defp options_for_value(:south_east, {x, y}), do: [{x, y + 1}, {x + 1, y}]
end
