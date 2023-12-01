defmodule CalorieCountingTest do
  use ExUnit.Case

  describe "count/2" do
    test "returns the largest single group of numbers" do
      file = """
      1
      2

      1
      3

      1
      1
      """

      assert CalorieCounting.count(String.split(file, "\n"), 1) == 4
    end

    test "returns the largest two group of numbers" do
      file = """
      1
      2

      1
      3

      1
      1
      """

      assert CalorieCounting.count(String.split(file, "\n"), 2) == 7
    end
  end
end
