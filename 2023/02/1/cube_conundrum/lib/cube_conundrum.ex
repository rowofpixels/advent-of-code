defmodule CubeConundrum do
  alias CubeConundrum.Parser

  @max_red_cubes 12
  @max_green_cubes 13
  @max_blue_cubes 14

  def calculate_possible_games(data) do
    data
    |> clean()
    |> Stream.map(&Parser.parse/1)
    |> Stream.filter(&possible_game/1)
    |> Stream.map(&(&1.id))
    |> Enum.sum()
  end

  defp possible_game(game), do: Enum.all?(game.hands, &possible_hand/1)
  defp possible_hand(hand) do
    red = Map.get(hand, "red", 0)
    green = Map.get(hand, "green", 0)
    blue = Map.get(hand, "blue", 0)

    red <= @max_red_cubes && green <= @max_green_cubes && blue <= @max_blue_cubes
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
end
