defmodule Wait do
  alias Wait.Parser

  def solve(input) do
    input
    |> Parser.parse()
    |> possible_win_count()
  end

  defp possible_win_count({time, distance}) do
    0..time
    |> Enum.filter(fn button ->
      button_wins(button, time, distance)
    end)
    |> Enum.count()
  end

  defp button_wins(button, time, distance), do: button * (time - button) > distance
end
