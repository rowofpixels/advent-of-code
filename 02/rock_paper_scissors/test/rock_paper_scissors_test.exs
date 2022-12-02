defmodule RockPaperScissorsTest do
  use ExUnit.Case

  describe "calculate/1" do
    test "returns 0 for an empty file" do
      file = """
      """

      assert RockPaperScissors.calculate(String.split(file, "\n")) == 0
    end

    test "returns 4 for A Y" do
      file = """
      A Y
      """

      assert RockPaperScissors.calculate(String.split(file, "\n")) == 4
    end

    test "returns 12 for A Y, B X, C Z" do
      file = """
      A Y
      B X
      C Z
      """

      assert RockPaperScissors.calculate(String.split(file, "\n")) == 12
    end
  end
end
