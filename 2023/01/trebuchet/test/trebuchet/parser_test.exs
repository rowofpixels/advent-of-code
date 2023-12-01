defmodule Trebuchet.ParserTest do
  use ExUnit.Case

  describe "parse_forward/1" do
    test "returns number for a single digit" do
      assert Trebuchet.Parser.parse_forward("1") == [1]
    end

    test "returns number for a single word" do
      assert Trebuchet.Parser.parse_forward("one") == [1]
    end

    test "returns correct list of numbers for a combination of words and digits" do
      assert Trebuchet.Parser.parse_forward("123onetwothree") == [1, 2, 3, 1, 2, 3]
    end

    test "drops non numbers" do
      assert Trebuchet.Parser.parse_forward("nonsense") == []
    end

    test "works with a combination of nonsense, words, and digits" do
      assert Trebuchet.Parser.parse_forward("mmkfive78thrzthree") == [5, 7, 8, 3]
    end

    test "handles poorly defined case" do
      assert Trebuchet.Parser.parse_forward("oneight") == [1]
    end
  end

  describe "parse_backward/1" do
    test "returns number for a single digit" do
      assert Trebuchet.Parser.parse_backward(String.reverse("1")) == [1]
    end

    test "returns number for a single word" do
      assert Trebuchet.Parser.parse_backward(String.reverse("one")) == [1]
    end

    test "returns correct list of numbers for a combination of words and digits" do
      assert Trebuchet.Parser.parse_backward(String.reverse("123onetwothree")) == [3, 2, 1, 3, 2, 1]
    end

    test "drops non numbers" do
      assert Trebuchet.Parser.parse_backward(String.reverse("nonsense")) == []
    end

    test "works with a combination of nonsense, words, and digits" do
      assert Trebuchet.Parser.parse_backward(String.reverse("mmkfive78thrzthree")) == [3, 8, 7, 5]
    end

    test "handles poorly defined case" do
      assert Trebuchet.Parser.parse_backward(String.reverse("oneight")) == [8]
    end
  end
end
