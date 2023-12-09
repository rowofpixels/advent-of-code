defmodule HauntedWastelandTest do
  use ExUnit.Case

  describe "solve/1" do
    test "returns the correct value for first example" do
      file = """
      LR

      11A = (11B, XXX)
      11B = (XXX, 11Z)
      11Z = (11B, XXX)
      22A = (22B, XXX)
      22B = (22C, 22C)
      22C = (22Z, 22Z)
      22Z = (22B, 22B)
      XXX = (XXX, XXX)
      """

      assert HauntedWasteland.solve(file) == 6
    end

    # test "returns the correct value for another example 1" do
    #   file = """
    #   L

    #   11A = (11Z, XXX)
    #   XXX = (XXX, XXX)
    #   """

    #   assert HauntedWasteland.solve(file) == 1
    # end

    # test "returns the correct value for another example 2" do
    #   file = """
    #   LLR

    #   11A = (11B, 11B)
    #   11B = (11B, 11C)
    #   11C = (11C, 11D)
    #   11D = (11D, 11E)
    #   11E = (11Z, 11B)
    #   11Z = (11Z, 11A)
    #   22A = (22B, 22B)
    #   22B = (22B, 22C)
    #   22C = (22C, 22D)
    #   22D = (22Z, 22B)
    #   22Z = (22Z, 22A)
    #   """

    #   assert HauntedWasteland.solve(file) == 34
    # end

    # test "returns the correct value for another example 3" do
    #   file = """
    #   LRLL

    #   11A = (11B, 11B)
    #   11B = (11B, 11C)
    #   11C = (11C, 11D)
    #   11D = (11D, 11E)
    #   11E = (11Z, 11B)
    #   11Z = (11Z, 11A)
    #   22A = (22B, 22C)
    #   22B = (22B, 22C)
    #   22C = (22C, 22D)
    #   22D = (22Z, 22B)
    #   22Z = (22Z, 22A)
    #   """

    #   assert HauntedWasteland.solve(file) == 43
    # end

    # test "returns the correct value for another example 4" do
    #   file = """
    #   LLLRLRLL

    #   11A = (11B, 11B)
    #   11B = (11B, 11C)
    #   11C = (11C, 11D)
    #   11D = (11D, 11E)
    #   11E = (11A, 11B)
    #   11Z = (11A, 11A)
    #   22A = (22B, 22B)
    #   22B = (22B, 22C)
    #   22C = (22C, 22D)
    #   22D = (22Z, 22B)
    #   22Z = (22A, 22A)
    #   """

    #   assert HauntedWasteland.solve(file) == 45
    # end

    # test "returns the correct value for another example 2" do
    #   file = """
    #   L

    #   11A = (11Z, XXX)
    #   22A = (22Z, XXX)
    #   XXX = (XXX, XXX)
    #   """

    #   assert HauntedWasteland.solve(file) == 1
    # end

    # test "returns the correct value for another example 3" do
    #   file = """
    #   L

    #   11A = (11Z, XXX)
    #   11Z = (11A, XXX)
    #   22A = (22Z, XXX)
    #   22Z = (22A, XXX)
    #   33A = (33B, XXX)
    #   33B = (33Z, XXX)
    #   XXX = (XXX, XXX)
    #   """

    #   assert HauntedWasteland.solve(file) == 2
    # end

    # test "returns the correct value for another example 4" do
    #   file = """
    #   LR

    #   11A = (11Z, 11A)
    #   11B = (11Z, 11B)
    #   11Z = (11A, 11B)
    #   22A = (22Z, 22A)
    #   22Z = (22A, 22Z)
    #   33A = (33B, 33A)
    #   33B = (33Z, 33B)
    #   """

    #   assert HauntedWasteland.solve(file) == 3
    # end
  end
end
