defmodule Cosmic.UtilsTest do
  use ExUnit.Case

  describe "expand_universe/1" do
    test "returns the expanded universe for a simple example" do
      universe = [
        [nil, nil, nil],
        [nil, :galaxy, nil],
        [nil, nil, nil]
      ]

      assert Cosmic.Utils.expand_universe(universe) == [
               [nil, nil, nil, nil, nil],
               [nil, nil, nil, nil, nil],
               [nil, nil, :galaxy, nil, nil],
               [nil, nil, nil, nil, nil],
               [nil, nil, nil, nil, nil]
             ]
    end

    test "returns the expanded universe for a more complex example" do
      universe = [
        [nil, nil, nil, :galaxy, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, :galaxy, nil, nil],
        [:galaxy, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, :galaxy, nil, nil, nil],
        [nil, :galaxy, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, :galaxy],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, :galaxy, nil, nil],
        [:galaxy, nil, nil, nil, :galaxy, nil, nil, nil, nil, nil]
      ]

      expanded_universe = [
        [nil, nil, nil, nil, :galaxy, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, :galaxy, nil, nil, nil],
        [:galaxy, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, :galaxy, nil, nil, nil, nil],
        [nil, :galaxy, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, :galaxy],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, :galaxy, nil, nil, nil],
        [:galaxy, nil, nil, nil, nil, :galaxy, nil, nil, nil, nil, nil, nil, nil]
      ]

      assert Cosmic.Utils.expand_universe(universe) == expanded_universe
    end
  end

  describe "galaxy_coordinates/1" do
    test "returns coordinates of galaxies for universe" do
      universe = [
        [nil, :galaxy, nil, nil],
        [nil, :galaxy, nil, nil],
        [nil, nil, nil, :galaxy]
      ]

      assert Cosmic.Utils.galaxy_coordinates(universe) == [
               {1, 0},
               {1, 1},
               {3, 2}
             ]
    end
  end

  describe "pair_coordinates/1" do
    test "returns list of paired coordinates" do
      coordinates = [
        {0, 1},
        {1, 2},
        {3, 4},
        {5, 6}
      ]

      assert Enum.sort(Cosmic.Utils.pair_coordinates(coordinates)) ==
               Enum.sort([
                 {{0, 1}, {1, 2}},
                 {{0, 1}, {3, 4}},
                 {{0, 1}, {5, 6}},
                 {{1, 2}, {3, 4}},
                 {{1, 2}, {5, 6}},
                 {{3, 4}, {5, 6}}
               ])
    end
  end
end
