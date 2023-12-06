defmodule Wait do
  alias Wait.Parser

  def solve(input) do
    input
    |> Parser.parse()
    |> Enum.map(&possible_win_count/1)
    |> multiply(1)
  end

  defp possible_win_count({time, distance}) do
    0..time
    |> Enum.filter(fn button ->
      button_wins(button, time, distance)
    end)
    |> Enum.count()
  end

  defp multiply([head | tail], result), do: multiply(tail, head * result)
  defp multiply([], result), do: result

  defp button_wins(button, time, distance), do: button * (time - button) > distance
end
