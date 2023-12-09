defmodule Mirage.Utils do
  def clean_stream(data) do
    data
    |> Stream.reject(fn value ->
      String.trim(value) == ""
    end)
    |> Stream.map(fn value ->
      String.trim(value, "\n")
    end)
  end

  def extrapolate_next_value(values) do
    tree = append_difference_lines(values, [values])
    _extrapolate_next_value(tree)
  end

  defp append_difference_lines(values, acc \\ []) do
    next_values =
      values
      |> Enum.chunk_every(2, 1)
      |> Enum.drop(-1)
      |> Enum.map(&difference/1)

    if Enum.all?(next_values, &(&1 == 0)) do
      acc ++ [next_values]
    else
      acc ++ [next_values] ++ append_difference_lines(next_values)
    end
  end

  defp difference([a, b]), do: b - a

  defp _extrapolate_next_value(tree) do
    tree
    |> Enum.reverse()
    |> Enum.reduce(0, fn current, last ->
      List.last(current) + last
    end)
  end
end
