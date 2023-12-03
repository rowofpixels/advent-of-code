defmodule GearRatios.UtilsTest do
  use ExUnit.Case

  describe "get_surrounding_values_from_matrix/3" do
    test "it returns the surrounding values" do
      matrix = [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
      ]

      assert GearRatios.Utils.get_surrounding_values_from_matrix(matrix, 1, 1) == [
               1,
               2,
               3,
               4,
               6,
               7,
               8,
               9
             ]
    end

    test "it handles edges" do
      matrix = [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
      ]

      assert GearRatios.Utils.get_surrounding_values_from_matrix(matrix, 0, 0) == [
               2,
               4,
               5
             ]
    end
  end
end
