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

      assert GearRatios.solve(String.split(file, "\n")) == 467_835
    end

    test "handles values at the end of the line" do
      file = """
      ..3
      .*.
      ..2
      """

      assert GearRatios.solve(String.split(file, "\n")) == 6
    end
  end
end
