defmodule RucksackReorganization do
  @lowercase_offset 96
  @uppercase_offset 38

  def total_priorities_for_duplicates(data) do
    data
    |> clean()
    |> Stream.map(&rucksack_to_compartments/1)
    |> Stream.map(&find_duplicate_item/1)
    |> Stream.map(&priority_for_item/1)
    |> Enum.sum()
  end

  defp clean(data) do
    data
    |> Stream.map(&String.trim/1)
    |> Stream.filter(&(&1 != ""))
  end

  defp rucksack_to_compartments(rucksack) do
    items = String.codepoints(rucksack)
    Enum.split(items, div(length(items), 2))
  end

  defp find_duplicate_item({compartment_a, compartment_b}) do
    compartment_b
    |> Enum.filter(&(&1 in compartment_a))
    |> hd()
  end

  defp priority_for_item(item), do: item |> String.to_charlist() |> hd() |> value_for_character()

  defp value_for_character(character) when character >= hd('a') and character <= hd('z'),
    do: character - @lowercase_offset

  defp value_for_character(character) when character >= hd('A') and character <= hd('Z'),
    do: character - @uppercase_offset
end
