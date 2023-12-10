defmodule PipeMazeTest do
  use ExUnit.Case

  describe "solve/1" do
    test "returns the correct value for the simplest example" do
      file = """
      .....
      .S-7.
      .|.|.
      .L-J.
      .....
      """

      assert PipeMaze.solve(file) == 4
    end

    test "returns the correct value for the more complex example" do
      file = """
      ..F7.
      .FJ|.
      SJ.L7
      |F--J
      LJ...
      """

      assert PipeMaze.solve(file) == 8
    end
  end
end
