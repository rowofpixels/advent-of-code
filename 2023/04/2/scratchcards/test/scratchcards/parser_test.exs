defmodule Scratchcards.ParserTest do
  use ExUnit.Case

  describe "parse/1" do
    test "returns correct data for card" do
      assert Scratchcards.Parser.parse("Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53") == %{
               winning: [41, 48, 83, 86, 17],
               owned: [83, 86, 6, 31, 17, 9, 48, 53]
             }
    end

    test "handles when label has multiple spaces" do
      assert Scratchcards.Parser.parse("Card  1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53") == %{
               winning: [41, 48, 83, 86, 17],
               owned: [83, 86, 6, 31, 17, 9, 48, 53]
             }
    end
  end
end
