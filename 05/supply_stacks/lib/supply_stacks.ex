defmodule SupplyStacks do
  alias SupplyStacks.Parser

  def rearrange(data), do: do_rearrange(data, &move_singles/2)
  def rearrange_multiple(data), do: do_rearrange(data, &move_multiples/2)

  defp do_rearrange(data, move_fn) do
    data
    |> clean()
    |> Enum.reduce(%{stacks: [], labels: []}, fn line, acc ->
      case Parser.parse(line) do
        {:ok, :stack, stacks} ->
          %{acc | stacks: stack(acc.stacks, stacks)}

        {:ok, :label, labels} ->
          %{acc | labels: labels}

        {:ok, :movement, [count, from, to]} ->
          %{acc | stacks: move_fn.(acc.stacks, {count, from, to})}
      end
    end)
    |> Map.get(:stacks)
    |> Enum.map(&Enum.take(&1, 1))
    |> Enum.join("")
  end

  defp clean(data) do
    data
    |> Stream.reject(fn value ->
      String.trim(value) == ""
    end)
    |> Stream.map(fn value ->
      String.trim(value, "\n")
    end)
  end

  defp stack(list_a, list_b) do
    list_b
    |> Enum.with_index()
    |> Enum.reduce(list_a, fn {item, index}, acc ->
      if Enum.at(acc, index) do
        List.replace_at(acc, index, Enum.at(acc, index) ++ [item])
      else
        List.insert_at(acc, index, [item])
      end
    end)
    |> Enum.map(fn stack ->
      Enum.reject(stack, fn value ->
        value == nil
      end)
    end)
  end

  defp move_singles(stacks, {0, _from, _to}), do: stacks

  defp move_singles(stacks, {count, from, to}) do
    taken = Enum.take(Enum.at(stacks, from - 1), 1)
    dropped = Enum.drop(Enum.at(stacks, from - 1), 1)

    stacks =
      stacks
      |> List.replace_at(from - 1, dropped)
      |> List.replace_at(to - 1, taken ++ Enum.at(stacks, to - 1))

    move_singles(stacks, {count - 1, from, to})
  end

  defp move_multiples(stacks, {count, from, to}) do
    taken = Enum.take(Enum.at(stacks, from - 1), count)
    dropped = Enum.drop(Enum.at(stacks, from - 1), count)

    stacks
    |> List.replace_at(from - 1, dropped)
    |> List.replace_at(to - 1, taken ++ Enum.at(stacks, to - 1))
  end
end
