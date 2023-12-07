defmodule Wait.ParserTest do
  use ExUnit.Case

  describe "parse/1" do
    test "returns correct data" do
      file = """
      Time:      7  15   30
      Distance:  9  40  200
      """

      assert Wait.Parser.parse(file) == {71530, 940200}
    end
  end
end
