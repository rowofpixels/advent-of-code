defmodule SupplyStacks.ParserTest do
  use ExUnit.Case

  describe "parse/1" do
    test "returns error for nonsense" do
      assert SupplyStacks.Parser.parse("nonsense") == {:error, "Invalid input"}
    end

    test "parses stack with one stack" do
      assert SupplyStacks.Parser.parse("[A]") == {:ok, :stack, ["A"]}
    end

    test "parses stack with two stacks" do
      assert SupplyStacks.Parser.parse("[A] [B]") == {:ok, :stack, ["A", "B"]}
    end

    test "parses stack with two stacks and a newline" do
      assert SupplyStacks.Parser.parse("[A] [B]") == {:ok, :stack, ["A", "B"]}
    end

    test "parses stack with three stacks where the middle one is empty" do
      assert SupplyStacks.Parser.parse("[A]    [B]") == {:ok, :stack, ["A", nil, "B"]}
    end

    test "parses stack with three stacks where the first and last ones are empty" do
      assert SupplyStacks.Parser.parse("    [A]    ") == {:ok, :stack, [nil, "A", nil]}
    end

    test "parses stack labels" do
      assert SupplyStacks.Parser.parse(" 1 ") == {:ok, :label, [1]}
    end

    test "parses multiple stack labels" do
      assert SupplyStacks.Parser.parse(" 1   2 ") == {:ok, :label, [1, 2]}
    end

    test "parses movement with single digit instructions" do
      assert SupplyStacks.Parser.parse("move 1 from 2 to 3") == {:ok, :movement, [1, 2, 3]}
    end

    test "parses movement with double digit instructions" do
      assert SupplyStacks.Parser.parse("move 10 from 20 to 30") == {:ok, :movement, [10, 20, 30]}
    end
  end
end
