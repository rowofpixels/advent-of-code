defmodule MirageTest do
  use ExUnit.Case

  describe "solve/1" do
    test "returns the correct value" do
      file = """
      0 3 6 9 12 15
      1 3 6 10 15 21
      10 13 16 21 30 45
      """

      assert Mirage.solve(String.split(file, "\n")) == 2
    end
  end
end
