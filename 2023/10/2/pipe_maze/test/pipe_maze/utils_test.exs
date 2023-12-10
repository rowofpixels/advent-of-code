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

  describe "replace_start/1" do
    test "returns coordinates of start and altered map" do
      map = [
        [:south_east, :horizontal, :south_west],
        [:vertical, :start, :north_west],
        [:north_east, :north_west, :ground]
      ]

      assert PipeMaze.Utils.replace_start(map) == {
               {1, 1},
               [
                 [:south_east, :horizontal, :south_west],
                 [:vertical, :south_east, :north_west],
                 [:north_east, :north_west, :ground]
               ]
             }
    end

    test "returns coordinates of start and altered map example 2" do
      map = [
        [:south_east, :vertical, :south_west],
        [:horizontal, :start, :ground],
        [:north_east, :horizontal, :ground]
      ]

      assert PipeMaze.Utils.replace_start(map) == {
               {1, 1},
               [
                 [:south_east, :vertical, :south_west],
                 [:horizontal, :north_west, :ground],
                 [:north_east, :horizontal, :ground]
               ]
             }
    end
  end

  describe "pad_map/1" do
    test "returns a padded version of a map" do
      map = [
        [:a, :b],
        [:c, :d]
      ]

      assert PipeMaze.Utils.pad_map(map, nil) == [
               [nil, nil, nil, nil],
               [nil, :a, :b, nil],
               [nil, :c, :d, nil],
               [nil, nil, nil, nil]
             ]
    end

    test "returns a padded version of a larger map" do
      map = [
        [:a, :b, :c],
        [:d, :e, :f]
      ]

      assert PipeMaze.Utils.pad_map(map, nil) == [
               [nil, nil, nil, nil, nil],
               [nil, :a, :b, :c, nil],
               [nil, :d, :e, :f, nil],
               [nil, nil, nil, nil, nil]
             ]
    end
  end

  describe "mark_superfluous/3" do
    test "it returns a cleaned version of a doubled map" do
      map = [
        [:a, :b, :c],
        [:d, :e, :f],
        [:g, :h, :i]
      ]

      keep = [
        {0, 0},
        {1, 1},
        {2, 1}
      ]

      assert PipeMaze.Utils.mark_superfluous(map, keep, :z) == [
               [:a, :z, :z],
               [:z, :e, :f],
               [:z, :z, :z]
             ]
    end
  end

  describe "outside_coordinates/2" do
    test "returns outside coordinates of a map" do
      map = [
        [nil, nil, nil, nil],
        [nil, nil, nil, nil],
        [nil, nil, nil, nil]
      ]

      assert Enum.sort(PipeMaze.Utils.outside_coordinates(map)) ==
               Enum.sort([
                 {0, 0},
                 {1, 0},
                 {2, 0},
                 {3, 0},
                 {0, 2},
                 {1, 2},
                 {2, 2},
                 {3, 2},
                 {0, 1},
                 {3, 1}
               ])
    end
  end

  describe "count_tiles/2" do
    test "returns correct count" do
      map = [
        [:ground, :north_west, :north_west, :ground],
        [:ground, :north_west, :empty, :north_west],
        [:ground, :ground, :ground, :ground]
      ]

      assert PipeMaze.Utils.count_tiles(map, :ground) == 7
      assert PipeMaze.Utils.count_tiles(map, :north_west) == 4
      assert PipeMaze.Utils.count_tiles(map, :empty) == 1
    end
  end
end
