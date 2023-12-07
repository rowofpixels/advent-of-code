defmodule CamelCards.Utils do
  @cards_by_strength [
    ?A,
    ?K,
    ?Q,
    ?J,
    ?T,
    ?9,
    ?8,
    ?7,
    ?6,
    ?5,
    ?4,
    ?3,
    ?2
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

  def hand_sorter(a, b) do
    a_hand_type_value = hand_type_value(a)
    b_hand_type_value = hand_type_value(b)

    cond do
      a_hand_type_value > b_hand_type_value ->
        true

      a_hand_type_value < b_hand_type_value ->
        false

      a_hand_type_value == b_hand_type_value ->
        hand_value(a) >= hand_value(b)
    end
  end

  def hand_type(hand) do
    cond do
      five_of_a_kind?(hand) ->
        :five_of_a_kind

      four_of_a_kind?(hand) ->
        :four_of_a_kind

      full_house?(hand) ->
        :full_house

      three_of_a_kind?(hand) ->
        :three_of_a_kind

      two_pair?(hand) ->
        :two_pair

      one_pair?(hand) ->
        :one_pair

      high_card?(hand) ->
        :high_card

      true ->
        throw("undefined hand type")
    end
  end

  defp hand_type_value(hand) do
    hand_type = hand_type(hand)

    @hand_types_by_strength
    |> Enum.reverse()
    |> Enum.find_index(&(&1 == hand_type))
  end

  defp hand_value(hand) do
    hand
    |> Tuple.to_list()
    |> Enum.map(&card_value/1)
    |> Enum.map(&Integer.to_string/1)
    |> Enum.map(&String.pad_leading(&1, 2, "0"))
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

  defp five_of_a_kind?(hand), do: match?([5], grouped_and_sorted_by_lengths(hand))
  defp four_of_a_kind?(hand), do: match?([1, 4], grouped_and_sorted_by_lengths(hand))
  defp full_house?(hand), do: match?([2, 3], grouped_and_sorted_by_lengths(hand))
  defp three_of_a_kind?(hand), do: match?([1, 1, 3], grouped_and_sorted_by_lengths(hand))
  defp two_pair?(hand), do: match?([1, 2, 2], grouped_and_sorted_by_lengths(hand))
  defp one_pair?(hand), do: match?([1, 1, 1, 2], grouped_and_sorted_by_lengths(hand))
  defp high_card?(hand), do: match?([1, 1, 1, 1, 1], grouped_and_sorted_by_lengths(hand))

  defp grouped_and_sorted_by_lengths(hand) do
    hand
    |> Tuple.to_list()
    |> Enum.group_by(& &1)
    |> Map.values()
    |> Enum.map(&length/1)
    |> Enum.sort()
  end
end
