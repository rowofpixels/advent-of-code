defmodule WaitTest do
  use ExUnit.Case

  describe "solve/1" do
    test "returns the correct value" do
      file = """
      Time:      7  15   30
      Distance:  9  40  200
      """

      assert Wait.solve(file) == 288
    end
  end
end
