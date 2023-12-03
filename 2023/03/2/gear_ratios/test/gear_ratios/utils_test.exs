defmodule GearRatios.UtilsTest do
  use ExUnit.Case

  # describe "generate_border_coordinates/3" do
  #   test "it returns border coordinates" do
  #     matrix = [
  #       [01, 02, 03, 04, 05],
  #       [06, 07, 08, 09, 10],
  #       [11, 12, 13, 14, 15],
  #       [16, 17, 18, 19, 20],
  #       [21, 22, 23, 24, 25]
  #     ]

  #     assert Utils.generate_border_coordinates(matrix, {2, 2}, {2, 2}) == [
  #              {0}
  #            ]
  #   end
  # end

  # describe "get_surrounding_values_from_matrix/3" do
  #   test "it returns the surrounding values" do
  #     matrix = [
  #       [1, 2, 3],
  #       [4, 5, 6],
  #       [7, 8, 9]
  #     ]

  #     assert GearRatios.Utils.get_surrounding_values_from_matrix(matrix, 1, 1) == [
  #              1,
  #              2,
  #              3,
  #              4,
  #              6,
  #              7,
  #              8,
  #              9
  #            ]
  #   end

  #   test "it handles edges" do
  #     matrix = [
  #       [1, 2, 3],
  #       [4, 5, 6],
  #       [7, 8, 9]
  #     ]

  #     assert GearRatios.Utils.get_surrounding_values_from_matrix(matrix, 0, 0) == [
  #              2,
  #              4,
  #              5
  #            ]
  #   end
  # end
end
