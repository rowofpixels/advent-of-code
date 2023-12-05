defmodule Fertilizer.ParserTest do
  use ExUnit.Case

  describe "parse/1" do
    test "returns correct data" do
      input = """
      seeds: 79 14 55 13

      seed-to-soil map:
      50 98 2
      52 50 48

      soil-to-fertilizer map:
      0 15 37
      37 52 2
      39 0 15

      fertilizer-to-water map:
      49 53 8
      0 11 42
      42 0 7
      57 7 4

      water-to-light map:
      88 18 7
      18 25 70

      light-to-temperature map:
      45 77 23
      81 45 19
      68 64 13

      temperature-to-humidity map:
      0 69 1
      1 0 69

      humidity-to-location map:
      60 56 37
      56 93 4
      """

      assert Fertilizer.Parser.parse(input) == %{
               seeds: [79, 14, 55, 13],
               fertilizer_to_water: [
                 [49, 53, 8],
                 [0, 11, 42],
                 [42, 0, 7],
                 [57, 7, 4]
               ],
               humidity_to_location: [
                 [60, 56, 37],
                 [56, 93, 4]
               ],
               light_to_temperature: [
                 [45, 77, 23],
                 [81, 45, 19],
                 [68, 64, 13]
               ],
               seed_to_soil: [
                 [50, 98, 2],
                 [52, 50, 48]
               ],
               soil_to_fertilizer: [
                 [0, 15, 37],
                 [37, 52, 2],
                 [39, 0, 15]
               ],
               temperature_to_humidity: [
                 [0, 69, 1],
                 [1, 0, 69]
               ],
               water_to_light: [
                 [88, 18, 7],
                 [18, 25, 70]
               ]
             }
    end
  end
end
