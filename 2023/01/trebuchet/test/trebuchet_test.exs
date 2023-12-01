defmodule TrebuchetTest do
  use ExUnit.Case

  describe "sum_calibration_values/1" do
    test "returns the correct value" do
      file = """
      1abc2
      pqr3stu8vwx
      a1b2c3d4e5f
      treb7uchet
      """

      assert Trebuchet.sum_calibration_values(String.split(file, "\n")) == 142
    end
  end

  describe "sum_calibration_values_with_spelling/1" do
    test "returns the correct value" do
      file = """
      two1nine
      eightwothree
      abcone2threexyz
      xtwone3four
      4nineeightseven2
      zoneight234
      7pqrstsixteen
      """

      assert Trebuchet.sum_calibration_values_with_spelling(String.split(file, "\n")) == 281
    end
  end
end
