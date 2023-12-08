defmodule HauntedWastelandTest do
  use ExUnit.Case

  describe "solve/1" do
    test "returns the correct value for first example" do
      file = """
      RL

      AAA = (BBB, CCC)
      BBB = (DDD, EEE)
      CCC = (ZZZ, GGG)
      DDD = (DDD, DDD)
      EEE = (EEE, EEE)
      GGG = (GGG, GGG)
      ZZZ = (ZZZ, ZZZ)
      """

      assert HauntedWasteland.solve(file) == 2
    end

    test "returns the correct value for second example" do
      file = """
      LLR

      AAA = (BBB, BBB)
      BBB = (AAA, ZZZ)
      ZZZ = (ZZZ, ZZZ)
      """

      assert HauntedWasteland.solve(file) == 6
    end
  end
end
