defmodule Trebuchet.Parser do
  @moduledoc """
  Parses the input file into numbers.
  """

  import NimbleParsec

  forward_number_parser = repeat(
    choice([
      string("one") |> replace(1),
      string("two") |> replace(2),
      string("three") |> replace(3),
      string("four") |> replace(4),
      string("five") |> replace(5),
      string("six") |> replace(6),
      string("seven") |> replace(7),
      string("eight") |> replace(8),
      string("nine") |> replace(9),
      string("1") |> replace(1),
      string("2") |> replace(2),
      string("3") |> replace(3),
      string("4") |> replace(4),
      string("5") |> replace(5),
      string("6") |> replace(6),
      string("7") |> replace(7),
      string("8") |> replace(8),
      string("9") |> replace(9),
      utf8_char([]) |> ignore()
    ])
  )

  backward_number_parser = repeat(
    choice([
      string(String.reverse("one")) |> replace(1),
      string(String.reverse("two")) |> replace(2),
      string(String.reverse("three")) |> replace(3),
      string(String.reverse("four")) |> replace(4),
      string(String.reverse("five")) |> replace(5),
      string(String.reverse("six")) |> replace(6),
      string(String.reverse("seven")) |> replace(7),
      string(String.reverse("eight")) |> replace(8),
      string(String.reverse("nine")) |> replace(9),
      string(String.reverse("1")) |> replace(1),
      string(String.reverse("2")) |> replace(2),
      string(String.reverse("3")) |> replace(3),
      string(String.reverse("4")) |> replace(4),
      string(String.reverse("5")) |> replace(5),
      string(String.reverse("6")) |> replace(6),
      string(String.reverse("7")) |> replace(7),
      string(String.reverse("8")) |> replace(8),
      string(String.reverse("9")) |> replace(9),
      utf8_char([]) |> ignore()
    ])
  )

  defparsec :forward_numbers, forward_number_parser
  defparsec :backward_numbers, backward_number_parser

  def parse_forward(input) do
    {:ok, result, "", _, _, _} = forward_numbers(input)

    result
  end

  def parse_backward(input) do
    {:ok, result, "", _, _, _} = backward_numbers(input)

    result
  end
end
