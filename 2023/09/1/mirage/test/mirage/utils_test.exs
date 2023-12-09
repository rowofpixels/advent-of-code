defmodule Mirage.UtilsTest do
  use ExUnit.Case

  describe "extrapolate_next_value/1" do
    test "returns the correct value for 1, 2, 3" do
      assert Mirage.Utils.extrapolate_next_value([1, 2, 3]) == 4
    end

    test "returns the correct value for 0, 3, 6, 9, 12, 15" do
      assert Mirage.Utils.extrapolate_next_value([0, 3, 6, 9, 12, 15]) == 18
    end

    test "returns the correct value for 1, 3, 6, 10, 15, 21" do
      assert Mirage.Utils.extrapolate_next_value([1, 3, 6, 10, 15, 21]) == 28
    end

    test "returns the correct value for 10, 13, 16, 21, 30, 45" do
      assert Mirage.Utils.extrapolate_next_value([10, 13, 16, 21, 30, 45]) == 68
    end
  end
end
