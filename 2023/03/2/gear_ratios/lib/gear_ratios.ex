defmodule GearRatios do
  alias GearRatios.Utils

  def solve(data) do
    data =
      data
      |> Utils.clean()
      |> Enum.map(fn line ->
        line
        |> String.graphemes()
        |> Enum.map(&drop_periods/1)
        |> Enum.map(&Utils.to_integer/1)
      end)

    data
    |> Enum.map(fn row -> Enum.with_index(row) end)
    |> Enum.with_index()
    |> Enum.reduce(%{gears: %{}, digits: []}, fn {row, row_index}, acc ->
      Enum.reduce(row, acc, fn {value, col_index}, %{gears: gears, digits: digits} ->
        cond do
          !is_number(value) ->
            if length(digits) > 0 do
              gears =
                data
                |> find_surrounding_gear_coordinates(
                  row_index,
                  col_index - length(digits),
                  col_index - 1
                )
                |> Enum.reduce(gears, fn coordinates, gears ->
                  Map.update(gears, coordinates, [digits], fn numbers ->
                    numbers ++ [digits]
                  end)
                end)

              %{
                gears: gears,
                digits: []
              }
            else
              %{gears: gears, digits: digits}
            end

          length(row) - 1 == col_index ->
            if is_number(value) do
              digits = digits ++ [value]

              gears =
                data
                |> find_surrounding_gear_coordinates(
                  row_index,
                  col_index - length(digits),
                  col_index
                )
                |> Enum.reduce(gears, fn coordinates, gears ->
                  Map.update(gears, coordinates, [digits], fn numbers ->
                    numbers ++ [digits]
                  end)
                end)

              %{
                gears: gears,
                digits: []
              }
            else
              %{gears: gears, digits: digits}
            end

          is_number(value) ->
            %{gears: gears, digits: digits ++ [value]}
        end
      end)
    end)
    |> Map.get(:gears)
    |> Map.values()
    |> Enum.filter(fn numbers ->
      length(numbers) == 2
    end)
    |> Enum.map(fn [first, second] ->
      digits_to_number(first) * digits_to_number(second)
    end)
    |> Enum.sum()
  end

  defp drop_periods("."), do: nil
  defp drop_periods(character), do: character

  defp find_surrounding_gear_coordinates(data, row, head, tail) do
    border_coordinates =
      Enum.map((head - 1)..(tail + 1), fn col -> {row - 1, col} end) ++
        [{row, head - 1}, {row, tail + 1}] ++
        Enum.map((head - 1)..(tail + 1), fn col -> {row + 1, col} end)

    border_coordinates
    |> Enum.filter(fn {row, col} ->
      case get_matrix_element(data, row, col) do
        {:ok, "*"} ->
          true

        _ ->
          false
      end
    end)
  end

  defp get_matrix_element(data, row, col) do
    if row < 0 || col < 0 do
      {:error, :out_of_bounds}
    else
      case Enum.fetch(data, row) do
        {:ok, value} ->
          case Enum.fetch(value, col) do
            {:ok, value} ->
              {:ok, value}

            :error ->
              {:error, :out_of_bounds}
          end

        :error ->
          {:error, :out_of_bounds}
      end
    end
  end

  defp digits_to_number(digits) do
    digits
    |> Enum.map(&to_string/1)
    |> Enum.join()
    |> Integer.parse()
    |> case do
      {value, ""} ->
        value
    end
  end
end
