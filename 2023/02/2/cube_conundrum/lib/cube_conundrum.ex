defmodule CubeConundrum do
  alias CubeConundrum.Parser

  def calculate(data) do
    data
    |> clean()
    |> Stream.map(&Parser.parse/1)
    |> Stream.map(&minimum_color_counts_required/1)
    |> Stream.map(&power/1)
    |> Enum.sum()
  end

  defp minimum_color_counts_required(game) do
    red = Enum.max(Enum.map(game.hands, &(Map.get(&1, "red", 0))))
    green = Enum.max(Enum.map(game.hands, &(Map.get(&1, "green", 0))))
    blue = Enum.max(Enum.map(game.hands, &(Map.get(&1, "blue", 0))))

    {red, green, blue}
  end

  defp power({red, green, blue}), do: red * green * blue

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
