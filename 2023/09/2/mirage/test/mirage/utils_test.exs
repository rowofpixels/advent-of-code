defmodule Mirage.UtilsTest do
  use ExUnit.Case

  describe "extrapolate_prev_value/1" do
    test "returns the correct value for 1, 2, 3" do
      assert Mirage.Utils.extrapolate_prev_value([1, 2, 3]) == 0
    end

    test "returns the correct value for 0, 3, 6, 9, 12, 15" do
      assert Mirage.Utils.extrapolate_prev_value([0, 3, 6, 9, 12, 15]) == -3
    end

    test "returns the correct value for 1, 3, 6, 10, 15, 21" do
      assert Mirage.Utils.extrapolate_prev_value([1, 3, 6, 10, 15, 21]) == 0
    end

    test "returns the correct value for 10, 13, 16, 21, 30, 45" do
      assert Mirage.Utils.extrapolate_prev_value([10, 13, 16, 21, 30, 45]) == 5
    end
  end
end
