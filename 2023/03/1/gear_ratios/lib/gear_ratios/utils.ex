defmodule GearRatios.Utils do
  def clean(data) do
    data
    |> Stream.reject(fn value ->
      String.trim(value) == ""
    end)
    |> Stream.map(fn value ->
      String.trim(value, "\n")
    end)
  end

  def get_surrounding_values_from_matrix(matrix, row, col) do
    coordinates = [
      {row - 1, col - 1},
      {row - 1, col},
      {row - 1, col + 1},
      {row, col - 1},
      {row, col + 1},
      {row + 1, col - 1},
      {row + 1, col},
      {row + 1, col + 1}
    ]

    Enum.reduce(coordinates, [], fn {row, col}, acc ->
      cond do
        row < 0 || col < 0 || row > length(matrix) || col > length(Enum.at(matrix, row)) ->
          acc

        true ->
          acc ++
            [
              matrix
              |> Enum.at(row)
              |> Enum.at(col)
            ]
      end
    end)
  end

  def string_digits_to_number(digits) do
    case digits
         |> Enum.join()
         |> Integer.parse() do
      {value, ""} ->
        value
    end
  end

  def is_digit?(nil), do: false

  def is_digit?(value) do
    case Integer.parse(value) do
      {value, ""} ->
        value

      _ ->
        false
    end
  end

  def is_symbol?(value) do
    !is_digit?(value) && !is_nil(value)
  end
end
