defmodule Trebuchet do
  @moduledoc """
  Documentation for `Trebuchet`.
  """

  alias Trebuchet.Parser

  def sum_calibration_values(data) do
    data
    |> clean()
    |> Stream.map(&calibration_value/1)
    |> Enum.sum()
  end

  def sum_calibration_values_with_spelling(data) do
    data
    |> clean()
    |> Stream.map(&calibration_value_with_spelling/1)
    |> Enum.sum()
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

  defp calibration_value(row) do
    forward = String.graphemes(row)
    backward = Enum.reverse(forward)

    first_digit(forward) * 10 + first_digit(backward)
  end

  defp first_digit(characters) do
    Enum.find_value(characters, fn(character) ->
      case Integer.parse(character) do
        :error ->
          nil
        {value, ""} ->
          value
      end
    end)
  end

  defp calibration_value_with_spelling(row) do
    first = row |> Parser.parse_forward() |> List.first()
    last = row |> String.reverse() |> Parser.parse_backward() |> List.first()

    first * 10 + last
  end
end
