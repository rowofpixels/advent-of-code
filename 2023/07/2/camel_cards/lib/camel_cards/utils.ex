defmodule CamelCards.Utils do
  @wildcard ?J
  @cards_by_strength [
    ?A,
    ?K,
    ?Q,
    ?T,
    ?9,
    ?8,
    ?7,
    ?6,
    ?5,
    ?4,
    ?3,
    ?2,
    ?J
  ]

  @hand_types_by_strength [
    :five_of_a_kind,
    :four_of_a_kind,
    :full_house,
    :three_of_a_kind,
    :two_pair,
    :one_pair,
    :high_card
  ]

  def clean_stream(data) do
    data
    |> Stream.reject(fn value ->
      String.trim(value) == ""
    end)
    |> Stream.map(fn value ->
      String.trim(value, "\n")
    end)
  end

  def hand_type_value(hand) do
    @hand_types_by_strength
    |> Enum.reverse()
    |> Enum.find_index(&(&1 == hand_type(hand)))
  end

  def hand_value(hand) do
    hand
    |> Tuple.to_list()
    |> Enum.map(&card_value/1)
    |> Enum.map(&Integer.to_string/1)
    |> Enum.map(&String.pad_leading(&1, 2, "0"))
    |> Enum.reverse()
    |> Enum.concat(["1"])
    |> Enum.reverse()
    |> Enum.join()
    |> Integer.parse()
    |> case do
      {value, ""} ->
        value
    end
  end

  defp card_value(card) do
    @cards_by_strength
    |> Enum.reverse()
    |> Enum.find_index(&(&1 == card))
  end

  def hand_type(hand), do: best_hand_type(grouped_and_sorted_by_lengths(hand))
  defp best_hand_type({0, [5]}), do: :five_of_a_kind
  defp best_hand_type({0, [1, 4]}), do: :four_of_a_kind
  defp best_hand_type({0, [2, 3]}), do: :full_house
  defp best_hand_type({0, [1, 1, 3]}), do: :three_of_a_kind
  defp best_hand_type({0, [1, 2, 2]}), do: :two_pair
  defp best_hand_type({0, [1, 1, 1, 2]}), do: :one_pair
  defp best_hand_type({0, [1, 1, 1, 1, 1]}), do: :high_card
  defp best_hand_type({5, []}), do: best_hand_type({5, [0]})

  defp best_hand_type({wildcards, groups}),
    do: best_hand_type({0, List.update_at(groups, length(groups) - 1, &(&1 + wildcards))})

  defp grouped_and_sorted_by_lengths(hand) do
    %{true => wildcards, false => non_wildcards} =
      hand
      |> Tuple.to_list()
      |> Enum.group_by(&wildcards_and_not/1)
      |> Map.put_new(true, [])
      |> Map.put_new(false, [])

    non_wildcards_count_groups =
      non_wildcards
      |> Enum.group_by(& &1)
      |> Map.values()
      |> Enum.map(&length/1)
      |> Enum.sort()

    {length(wildcards), non_wildcards_count_groups}
  end

  defp wildcards_and_not(@wildcard), do: true
  defp wildcards_and_not(_value), do: false
end
