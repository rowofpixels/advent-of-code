defmodule CamelCardsTest do
  use ExUnit.Case

  describe "solve/1" do
    test "returns the correct value" do
      file = """
      32T3K 765
      T55J5 684
      KK677 28
      KTJJT 220
      QQQJA 483
      """

      assert CamelCards.solve(String.split(file, "\n")) == 5905
    end
  end
end
