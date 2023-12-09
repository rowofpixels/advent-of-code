defmodule Mirage.ParserTest do
  use ExUnit.Case

  describe "parse/1" do
    test "returns integers" do
      input = "123 456 789"

      assert Mirage.Parser.parse(input) == [123, 456, 789]
    end

    test "handles negatives" do
      input = "-123 456 -789"

      assert Mirage.Parser.parse(input) == [-123, 456, -789]
    end
  end
end
