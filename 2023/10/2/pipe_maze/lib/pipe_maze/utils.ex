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

  def replace_start(map) do
    {x, y} = coordinates = find_coordinates(map, :start)

    other_coordinates =
      coordinates
      |> surrounding_coordinates()
      |> Enum.map(fn surrounding_coordinate ->
        case options_for_coordinates(map, surrounding_coordinate) do
          [^coordinates, _other] ->
            surrounding_coordinate

          [_other, ^coordinates] ->
            surrounding_coordinate

          _ ->
            nil
        end
      end)
      |> Enum.reject(&is_nil/1)

    replace_with =
      [
        :horizontal,
        :vertical,
        :north_east,
        :north_west,
        :south_west,
        :south_east
      ]
      |> Enum.find(fn type ->
        options = options_for_value(type, coordinates)

        other_coordinates -- options == []
      end)

    altered_map = replace_by_coordinate(map, {x, y}, replace_with)

    {coordinates, altered_map}
  end

  defp replace_by_coordinate(map, {x, y}, value) do
    map
    |> Enum.with_index()
    |> Enum.map(fn
      {row, ^y} ->
        row
        |> Enum.with_index()
        |> Enum.map(fn
          {_value, ^x} ->
            value

          {value, _} ->
            value
        end)

      {row, _} ->
        row
    end)
  end

  def pad_map([head | _tail] = map, value) do
    width = length(head)

    pad_row = List.duplicate(value, width + 2)

    padded_map =
      Enum.map(map, fn row ->
        [value] ++ row ++ [value]
      end)

    [pad_row] ++ padded_map ++ [pad_row]
  end

  defp value_for_coordinates(_map, {x, _y}) when x < 0, do: nil
  defp value_for_coordinates(_map, {_x, y}) when y < 0, do: nil
  defp value_for_coordinates([head, _tail], {x, _y}) when x > length(head) - 1, do: nil
  defp value_for_coordinates(map, {_x, y}) when y > length(map) - 1, do: nil

  defp value_for_coordinates(map, {x, y}) do
    map
    |> Enum.at(y)
    |> Enum.at(x)
  end

  def mark_superfluous(map, keep, other) do
    map
    |> Enum.with_index()
    |> Enum.map(fn {row, y} ->
      row
      |> Enum.with_index()
      |> Enum.map(fn {value, x} ->
        if Enum.member?(keep, {x, y}) do
          value
        else
          other
        end
      end)
    end)
  end

  def outside_coordinates([head | _tail] = map) do
    height = length(map)
    width = length(head)

    top = Enum.map(0..(width - 1), &{&1, 0})
    bottom = Enum.map(0..(width - 1), &{&1, height - 1})
    left = Enum.map(0..(height - 1), &{0, &1})
    right = Enum.map(0..(height - 1), &{width - 1, &1})

    Enum.uniq(top ++ bottom ++ left ++ right)
  end

  def count_tiles(map, type) do
    map
    |> Enum.map(fn row ->
      Enum.count(row, fn value ->
        value == type
      end)
    end)
    |> Enum.sum()
  end

  def flood_map(map, coordinates) do
    flood_coordinates = _flood_map(map, coordinates)

    map
    |> Enum.with_index()
    |> Enum.map(fn {row, y} ->
      row
      |> Enum.with_index()
      |> Enum.map(fn {value, x} ->
        if Enum.any?(flood_coordinates, fn coordinates ->
             coordinates == {x, y}
           end) do
          :flood
        else
          value
        end
      end)
    end)
  end

  def _flood_map(map, flooded) do
    new_flooded =
      flooded
      |> Enum.flat_map(fn look ->
        new = [look]

        new = new ++ try_to_flood_north(map, look)
        new = new ++ try_to_flood_east(map, look)
        new = new ++ try_to_flood_south(map, look)
        new ++ try_to_flood_west(map, look)
      end)
      |> Enum.uniq()

    # Flood has stopped
    # IO.inspect(length(new_flooded), label: "How long")
    # if length(new_flooded) > 587 do
    #   flooded
    # else
    #   _flood_map(map, new_flooded)
    # end
    if length(new_flooded) == length(flooded) do
      flooded
    else
      _flood_map(map, new_flooded)
    end
  end

  defp try_to_flood_north(map, {x, y}) do
    north = {x, y - 0.5}

    left = value_for_coordinates(map, floored(north))
    right = value_for_coordinates(map, ceilinged(north))

    if !pipe?(map, north) && (can_flood_default(left, right) || can_flood_north(left, right)) do
      [north]
    else
      []
    end
  end

  defp try_to_flood_east(map, {x, y}) do
    east = {x + 0.5, y}

    top = value_for_coordinates(map, floored(east))
    bottom = value_for_coordinates(map, ceilinged(east))

    if !pipe?(map, east) && (can_flood_default(top, bottom) || can_flood_east(top, bottom)) do
      [east]
    else
      []
    end
  end

  defp try_to_flood_south(map, {x, y}) do
    south = {x, y + 0.5}

    left = value_for_coordinates(map, floored(south))
    right = value_for_coordinates(map, ceilinged(south))

    if !pipe?(map, south) && (can_flood_default(left, right) || can_flood_south(left, right)) do
      [south]
    else
      []
    end
  end

  defp try_to_flood_west(map, {x, y}) do
    west = {x - 0.5, y}

    top = value_for_coordinates(map, floored(west))
    bottom = value_for_coordinates(map, ceilinged(west))

    if !pipe?(map, west) && (can_flood_default(top, bottom) || can_flood_west(top, bottom)) do
      [west]
    else
      []
    end
  end

  defp pipe?(map, {x, y}) do
    if round(x) == x && round(y) == y do
      case value_for_coordinates(map, {round(x), round(y)}) do
        :vertical ->
          true

        :horizontal ->
          true

        :north_east ->
          true

        :south_east ->
          true

        :south_west ->
          true

        :north_west ->
          true

        _any ->
          false
      end
    else
      false
    end
  end

  defp can_flood_default(nil, _b), do: false
  defp can_flood_default(_a, nil), do: false
  defp can_flood_default(:ground, _b), do: true
  defp can_flood_default(_a, :ground), do: true
  defp can_flood_default(:ground, :ground), do: true
  defp can_flood_default(_a, _b), do: false

  defp can_flood_north(left, right) do
    if is_nil(left) || is_nil(right) || (has_east?(left) && has_west?(right)) do
      false
    else
      true
    end
  end

  defp can_flood_east(top, bottom) do
    if is_nil(top) || is_nil(bottom) || (has_south?(top) && has_north?(bottom)) do
      false
    else
      true
    end
  end

  defp can_flood_south(left, right), do: can_flood_north(left, right)
  defp can_flood_west(top, bottom), do: can_flood_east(top, bottom)

  defp has_north?(value), do: Enum.member?([:vertical, :north_east, :north_west], value)
  defp has_east?(value), do: Enum.member?([:horizontal, :north_east, :south_east], value)
  defp has_south?(value), do: Enum.member?([:vertical, :south_east, :south_west], value)
  defp has_west?(value), do: Enum.member?([:horizontal, :north_west, :south_west], value)

  defp floored({x, y}), do: {floor(x), floor(y)}
  defp ceilinged({x, y}), do: {ceil(x), ceil(y)}

  # defp floodable_coordinates?(map, coordinates),
  #   do: floodable_value?(value_for_coordinates(map, coordinates))

  # defp floodable_value?(nil), do: false
  # defp floodable_value?(:ground), do: true
  # defp floodable_value?(:horizontal), do: false
  # defp floodable_value?(:vertical), do: false
  # defp floodable_value?(:north_east), do: false
  # defp floodable_value?(:north_west), do: false
  # defp floodable_value?(:south_east), do: false
  # defp floodable_value?(:south_west), do: false
  # defp floodable_value?(:empty), do: true

  def file_write_map(map, filename) do
    contents =
      map
      |> Enum.map(fn row ->
        row
        |> Enum.map(fn
          :ground ->
            "."

          :horizontal ->
            "-"

          :vertical ->
            "|"

          :north_east ->
            "L"

          :north_west ->
            "J"

          :south_east ->
            "F"

          :south_west ->
            "7"

          :empty ->
            " "

          :flood ->
            "W"
        end)
        |> Enum.join()
      end)
      |> Enum.join("\n")

    File.write!("tmp/#{filename}", contents)
  end
end
