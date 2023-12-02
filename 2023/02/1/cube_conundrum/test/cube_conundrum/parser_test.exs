defmodule CubeConundrum.ParserTest do
  use ExUnit.Case

  describe "parse/1" do
    test "returns correct data for game with a single hand and a single color" do
      assert CubeConundrum.Parser.parse("Game 1: 1 red") == %{id: 1, hands: [%{"red" => 1}]}
    end

    test "returns correct data for a game with a single hand and two colors" do
      assert CubeConundrum.Parser.parse("Game 2: 3 red, 4 blue") == %{
               id: 2,
               hands: [%{"red" => 3, "blue" => 4}]
             }
    end

    test "returns correct data for a game with two hands of one and two colors" do
      assert CubeConundrum.Parser.parse("Game 3: 4 red, 5 blue; 6 green, 7 red") == %{
               id: 3,
               hands: [
                 %{"red" => 4, "blue" => 5},
                 %{"green" => 6, "red" => 7}
               ]
             }
    end
  end
end
