defmodule NoSpaceLeftOnDeviceTest do
  use ExUnit.Case

  describe "build_tree/1" do
    test "returns a tree" do
      assert NoSpaceLeftOnDevice.build_tree(1) == [1]
    end
  end

  test "greets the world" do
    assert NoSpaceLeftOnDevice.hello() == :world
  end
end
