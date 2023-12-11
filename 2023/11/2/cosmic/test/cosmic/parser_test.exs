defmodule Cosmic.ParserTest do
  use ExUnit.Case

  describe "parse/1" do
    test "returns universe" do
      input = """
      ...
      .#.
      ...
      """

      assert Cosmic.Parser.parse(input) == [
               [nil, nil, nil],
               [nil, :galaxy, nil],
               [nil, nil, nil]
             ]
    end
  end
end
