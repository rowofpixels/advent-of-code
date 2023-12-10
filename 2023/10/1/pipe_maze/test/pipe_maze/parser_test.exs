defmodule PipeMaze.ParserTest do
  use ExUnit.Case

  describe "parse/1" do
    test "handles a simple pipe layout" do
      input = """
      .....
      .F-7.
      .|.|.
      .L-J.
      .....
      """

      assert PipeMaze.Parser.parse(input) == [
               [:ground, :ground, :ground, :ground, :ground],
               [:ground, :south_east, :horizontal, :south_west, :ground],
               [:ground, :vertical, :ground, :vertical, :ground],
               [:ground, :north_east, :horizontal, :north_west, :ground],
               [:ground, :ground, :ground, :ground, :ground]
             ]
    end

    test "handles a simple pipe layout with a start" do
      input = """
      .....
      .S-7.
      .|.|.
      .L-J.
      .....
      """

      assert PipeMaze.Parser.parse(input) == [
               [:ground, :ground, :ground, :ground, :ground],
               [:ground, :start, :horizontal, :south_west, :ground],
               [:ground, :vertical, :ground, :vertical, :ground],
               [:ground, :north_east, :horizontal, :north_west, :ground],
               [:ground, :ground, :ground, :ground, :ground]
             ]
    end
  end
end
