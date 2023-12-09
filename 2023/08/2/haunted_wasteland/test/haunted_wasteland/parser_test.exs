defmodule HauntedWasteland.ParserTest do
  use ExUnit.Case

  describe "parse/1" do
    test "returns correct data for first example" do
      input = """
      RL

      AAA = (BBB, CCC)
      BBB = (DDD, EEE)
      CCC = (ZZZ, GGG)
      DDD = (DDD, DDD)
      EEE = (EEE, EEE)
      GGG = (GGG, GGG)
      ZZZ = (ZZZ, ZZZ)
      """

      assert HauntedWasteland.Parser.parse(input) == {
               [:right, :left],
               %{
                 "AAA" => {"BBB", "CCC"},
                 "BBB" => {"DDD", "EEE"},
                 "CCC" => {"ZZZ", "GGG"},
                 "DDD" => {"DDD", "DDD"},
                 "EEE" => {"EEE", "EEE"},
                 "GGG" => {"GGG", "GGG"},
                 "ZZZ" => {"ZZZ", "ZZZ"}
               }
             }
    end

    test "returns correct data for second example" do
      input = """
      LLR

      AAA = (BBB, BBB)
      BBB = (AAA, ZZZ)
      ZZZ = (ZZZ, ZZZ)
      """

      assert HauntedWasteland.Parser.parse(input) == {
               [:left, :left, :right],
               %{
                 "AAA" => {"BBB", "BBB"},
                 "BBB" => {"AAA", "ZZZ"},
                 "ZZZ" => {"ZZZ", "ZZZ"}
               }
             }
    end

    test "returns correct data for third example" do
      input = """
      LR

      11A = (11B, XXX)
      11B = (XXX, 11Z)
      11Z = (11B, XXX)
      22A = (22B, XXX)
      22B = (22C, 22C)
      22C = (22Z, 22Z)
      22Z = (22B, 22B)
      XXX = (XXX, XXX)
      """

      assert HauntedWasteland.Parser.parse(input) == {
               [:left, :right],
               %{
                 "11A" => {"11B", "XXX"},
                 "11B" => {"XXX", "11Z"},
                 "11Z" => {"11B", "XXX"},
                 "22A" => {"22B", "XXX"},
                 "22B" => {"22C", "22C"},
                 "22C" => {"22Z", "22Z"},
                 "22Z" => {"22B", "22B"},
                 "XXX" => {"XXX", "XXX"}
               }
             }
    end
  end
end
