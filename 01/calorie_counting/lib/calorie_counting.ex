defmodule CalorieCounting do
  def count(data, groups) do
    data
    |> Stream.map(&String.trim/1)
    |> Stream.chunk_while([], &chunk_fun/2, &after_fun/1)
    |> Stream.map(&total_calories/1)
    |> Enum.reduce([], &largest_groups(&1, &2, groups))
    |> Enum.sum()
  end

  defp chunk_fun("", acc), do: {:cont, acc, []}
  defp chunk_fun(element, acc), do: {:cont, [element | acc]}

  defp after_fun([]), do: {:cont, []}
  defp after_fun(acc), do: {:cont, acc, []}

  defp total_calories(chunk) do
    chunk
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end

  defp largest_groups(new, acc, groups) do
    [new | acc]
    |> Enum.sort()
    |> Enum.take(-groups)
  end
end
