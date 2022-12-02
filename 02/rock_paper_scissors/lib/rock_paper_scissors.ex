defmodule RockPaperScissors do
  @shapes_by_letter %{
    "A" => :rock,
    "B" => :paper,
    "C" => :scissors
  }

  @outcomes_by_letter %{
    "X" => :loss,
    "Y" => :draw,
    "Z" => :win
  }

  @scores_by_shape %{
    rock: 1,
    paper: 2,
    scissors: 3
  }

  @scores_by_round %{
    win: 6,
    draw: 3,
    loss: 0
  }

  @shapes_by_strength %{
    rock: :scissors,
    paper: :rock,
    scissors: :paper
  }

  @shapes_by_weakness %{
    scissors: :rock,
    rock: :paper,
    paper: :scissors
  }

  def calculate(data) do
    {_player_1_score, player_2_score} =
      data
      |> Stream.map(&String.trim/1)
      |> Stream.reject(&blank?/1)
      |> Stream.map(&String.split(&1, " "))
      |> Stream.map(&letters_to_tuple/1)
      |> Stream.map(&letters_to_meanings/1)
      |> Stream.map(&meanings_to_shapes/1)
      |> Stream.map(&calculate_round/1)
      |> Enum.reduce({0, 0}, fn {player_1_score, player_2_score},
                                {total_player_1_score, total_player_2_score} ->
        {total_player_1_score + player_1_score, total_player_2_score + player_2_score}
      end)

    player_2_score
  end

  defp blank?(value), do: value == ""

  defp letters_to_tuple([letter_1, letter_2]), do: {letter_1, letter_2}

  defp letters_to_meanings({player_1, player_2}),
    do: {
      @shapes_by_letter[player_1],
      @outcomes_by_letter[player_2]
    }

  defp meanings_to_shapes({player_1_shape, player_2_outcome}),
    do: {player_1_shape, shape_for_outcome(player_1_shape, player_2_outcome)}

  defp calculate_round({player_a, player_b}) do
    {
      score(player_a, player_b),
      score(player_b, player_a)
    }
  end

  defp score(shape_a, shape_b), do: shape_score(shape_a) + round_score(shape_a, shape_b)

  defp shape_score(shape), do: @scores_by_shape[shape]

  defp round_score(shape_a, shape_b) when shape_a == shape_b, do: @scores_by_round[:draw]

  defp round_score(shape_a, shape_b) do
    if shape_a == @shapes_by_strength[shape_b] do
      @scores_by_round[:loss]
    else
      @scores_by_round[:win]
    end
  end

  defp shape_for_outcome(shape, :loss), do: @shapes_by_strength[shape]
  defp shape_for_outcome(shape, :draw), do: shape
  defp shape_for_outcome(shape, :win), do: @shapes_by_weakness[shape]
end
