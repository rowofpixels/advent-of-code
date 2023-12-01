defmodule TrebuchetTest do
  use ExUnit.Case

  describe "sum_calibration_values/1" do
    test "returns 2 for the given example" do
      file = """
      1abc2
      pqr3stu8vwx
      a1b2c3d4e5f
      treb7uchet
      """

      assert Trebuchet.sum_calibration_values(String.split(file, "\n")) == 142
    end
  end
end
