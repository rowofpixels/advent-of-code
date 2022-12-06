defmodule SupplyStacks.Parser do
  @moduledoc """
  Parses the input file into a list of stacks.
  """

  import NimbleParsec

  crate =
    optional(ignore(string(" ")))
    |> ignore(string("["))
    |> ascii_string([?A..?Z], 1)
    |> ignore(string("]"))

  no_crate =
    string("    ")
    |> replace(nil)

  stack_line_parser =
    repeat(
      choice([
        crate,
        no_crate
      ])
    )

  label_line_parser =
    repeat(
      ignore(string(" "))
      |> ignore(optional(string(" ")))
      |> integer(min: 1)
      |> optional(ignore(string(" ")))
    )

  movement_line_parser =
    ignore(string("move "))
    |> integer(min: 1)
    |> ignore(string(" from "))
    |> integer(min: 1)
    |> ignore(string(" to "))
    |> integer(min: 1)

  defparsecp(
    :do_parse_stack_line,
    stack_line_parser
  )

  defparsecp(
    :do_parse_label_line,
    label_line_parser
  )

  defparsecp(
    :do_parse_movement_line,
    movement_line_parser
  )

  def parse(input) do
    with :error <- wrap_result(:stack, do_parse_stack_line(input)),
         :error <- wrap_result(:label, do_parse_label_line(input)),
         :error <- wrap_result(:movement, do_parse_movement_line(input)) do
      {:error, "Invalid input"}
    end
  end

  defp wrap_result(type, {:ok, result, "", _, _, _}), do: {:ok, type, result}
  defp wrap_result(_, _), do: :error
end
