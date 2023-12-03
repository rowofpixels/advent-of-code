defmodule GearRatios do
  alias GearRatios.Utils

  def solve(data) do
    data
    |> Utils.clean()
    |> Stream.map(&parse/1)
    |> pad()
    |> Stream.chunk_every(3, 1)
    |> Stream.drop(-1)
    |> Stream.flat_map(&part_numbers/1)
    |> Enum.sum()
  end

  defp parse(line) do
    line
    |> String.graphemes()
    |> Enum.map(&drop_periods/1)
  end

  defp drop_periods("."), do: nil
  defp drop_periods(character), do: character

  defp pad(data), do: [[]] |> Stream.concat(data) |> Stream.concat([[]])

  defp part_numbers([_previous, current, _next] = rows) do
    current
    |> Enum.with_index()
    |> Enum.reduce(%{numbers: [], is_previous_digit: false}, fn {value, index},
                                                                %{
                                                                  numbers: numbers,
                                                                  is_previous_digit:
                                                                    is_previous_digit
                                                                } ->
      if Utils.is_digit?(value) do
        surrounding = Utils.get_surrounding_values_from_matrix(rows, 1, index)

        if is_previous_digit do
          {digits, valid} = List.last(numbers)
          new_last_digits = digits ++ [value]
          new_last_valid = valid || Enum.any?(surrounding, &Utils.is_symbol?/1)

          %{
            numbers: Enum.drop(numbers, -1) ++ [{new_last_digits, new_last_valid}],
            is_previous_digit: true
          }
        else
          %{
            numbers: numbers ++ [{[value], Enum.any?(surrounding, &Utils.is_symbol?/1)}],
            is_previous_digit: true
          }
        end
      else
        %{
          numbers: numbers,
          is_previous_digit: false
        }
      end
    end)
    |> Map.get(:numbers)
    |> Enum.filter(&elem(&1, 1))
    |> Enum.map(&elem(&1, 0))
    |> Enum.map(&Utils.string_digits_to_number/1)
  end
end
