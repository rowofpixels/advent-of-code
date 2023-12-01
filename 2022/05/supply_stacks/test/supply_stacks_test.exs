defmodule SupplyStacksTest do
  use ExUnit.Case

  describe "rearrange/1" do
    test "returns 2 for the given example" do
      file = """
          [D]
      [N] [C]
      [Z] [M] [P]
       1   2   3

      move 1 from 2 to 1
      move 3 from 1 to 3
      move 2 from 2 to 1
      move 1 from 1 to 2
      """

      assert SupplyStacks.rearrange(String.split(file, "\n")) == "CMZ"
    end
  end

  describe "rearrange_multiple/1" do
    test "returns 2 for the given example" do
      file = """
          [D]
      [N] [C]
      [Z] [M] [P]
       1   2   3

      move 1 from 2 to 1
      move 3 from 1 to 3
      move 2 from 2 to 1
      move 1 from 1 to 2
      """

      assert SupplyStacks.rearrange_multiple(String.split(file, "\n")) == "MCD"
    end
  end
end
