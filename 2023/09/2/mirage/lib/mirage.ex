defmodule Mirage do
  alias Mirage.Parser
  alias Mirage.Utils

  def solve(input) do
    input
    |> Utils.clean_stream()
    |> Stream.map(&Parser.parse/1)
    |> Stream.map(&Utils.extrapolate_prev_value/1)
    |> Enum.sum()
  end
end
