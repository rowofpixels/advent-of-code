defmodule GearRatiosTest do
  use ExUnit.Case

  describe "solve/1" do
    test "returns the correct value" do
      file = """
      467..114..
      ...*......
      ..35..633.
      ......#...
      617*......
      .....+.58.
      ..592.....
      ......755.
      ...$.*....
      .664.598..
      """

      assert GearRatios.solve(String.split(file, "\n")) == 4361
    end
  end
end
