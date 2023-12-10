defmodule PipeMazeTest do
  use ExUnit.Case

  describe "solve/1" do
    test "returns the correct value for example 1" do
      file = """
      ...........
      .S-------7.
      .|F-----7|.
      .||.....||.
      .||.....||.
      .|L-7.F-J|.
      .|..|.|..|.
      .L--J.L--J.
      ...........
      """

      assert PipeMaze.solve(file) == 4
    end

    test "returns the correct value for example 2" do
      file = """
      ..........
      .S------7.
      .|F----7|.
      .||....||.
      .||....||.
      .|L-7F-J|.
      .|..||..|.
      .L--JL--J.
      ..........
      """

      assert PipeMaze.solve(file) == 4
    end

    test "returns the correct value for example 3" do
      file = """
      FF7FSF7F7F7F7F7F---7
      L|LJ||||||||||||F--J
      FL-7LJLJ||||||LJL-77
      F--JF--7||LJLJ7F7FJ-
      L---JF-JLJ.||-FJLJJ7
      |F|F-JF---7F7-L7L|7|
      |FFJF7L7F-JF7|JL---7
      7-L-JL7||F7|L7F-7F7|
      L.L7LFJ|||||FJL7||LJ
      L7JLJL-JLJLJL--JLJ.L
      """

      assert PipeMaze.solve(file) == 10
    end
  end
end
