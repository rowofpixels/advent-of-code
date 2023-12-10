defmodule PipeMaze.UtilsTest do
  use ExUnit.Case

  describe "find_coordinates/2" do
    test "returns nil when value is not found" do
      map = [
        [:ground, :horizontal, :horizontal],
        [:north_east, :vertical, :north_east],
        [:north_west, :north_west, :south_west]
      ]

      assert PipeMaze.Utils.find_coordinates(map, :nonsense) == nil
    end

    test "returns the correct coordinates" do
      map = [
        [:ground, :horizontal, :horizontal],
        [:north_east, :vertical, :north_east],
        [:north_west, :north_west, :south_west]
      ]

      assert PipeMaze.Utils.find_coordinates(map, :vertical) == {1, 1}
    end
  end

  describe "build_loop/3" do
    test "returns the list of coordinates for the loop" do
      map = [
        [:ground, :ground, :ground, :ground, :ground],
        [:ground, :south_east, :horizontal, :south_west, :ground],
        [:ground, :vertical, :ground, :vertical, :ground],
        [:ground, :north_east, :horizontal, :north_west, :ground],
        [:ground, :ground, :ground, :ground, :ground]
      ]

      assert PipeMaze.Utils.build_loop(map, {1, 1}) == [
               {1, 1},
               {1, 2},
               {1, 3},
               {2, 3},
               {3, 3},
               {3, 2},
               {3, 1},
               {2, 1}
             ]
    end
  end
end
