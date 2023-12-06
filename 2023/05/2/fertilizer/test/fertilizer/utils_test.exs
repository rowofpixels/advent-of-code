defmodule Fertilizer.UtilsTest do
  use ExUnit.Case

  describe "expand_ranges_from_destination_to_source/2" do
    test "head starts within reference and ends within reference" do
      head = [{79, nil, 14}]
      reference = [{52, 50, 48}]

      assert Fertilizer.Utils.expand_ranges_from_destination_to_source(head, reference) == [
               {81, nil, 14}
             ]
    end

    test "head starts before reference and ends within reference with head length much larger" do
      head = [{23, nil, 100}]
      reference = [{71, 96, 31}]

      assert Fertilizer.Utils.expand_ranges_from_destination_to_source(head, reference) == [
               {23, nil, 73},
               {71, nil, 27}
             ]
    end

    test "head starts before reference and ends within reference with reference length much larger" do
      head = [{23, nil, 15}]
      reference = [{71, 32, 128}]

      assert Fertilizer.Utils.expand_ranges_from_destination_to_source(head, reference) == [
               {23, nil, 9},
               {71, nil, 6}
             ]
    end

    test "head starts before reference and ends after reference" do
      head = [{23, nil, 85}]
      reference = [{71, 36, 31}]

      assert Fertilizer.Utils.expand_ranges_from_destination_to_source(head, reference) == [
               {23, nil, 13},
               {71, nil, 31},
               {67, nil, 41}
             ]
    end

    test "head starts within reference and ends after reference with head length much larger" do
      head = [{83, nil, 100}]
      reference = [{71, 36, 50}]

      assert Fertilizer.Utils.expand_ranges_from_destination_to_source(head, reference) == [
               {118, nil, 3},
               {86, nil, 97}
             ]
    end

    test "head starts within reference and ends after reference with reference length much larger" do
      head = [{83, nil, 10}]
      reference = [{71, 36, 50}]

      assert Fertilizer.Utils.expand_ranges_from_destination_to_source(head, reference) == [
               {118, nil, 3},
               {86, nil, 7}
             ]
    end

    test "head matches reference" do
      head = [{83, nil, 10}]
      reference = [{100, 83, 10}]

      assert Fertilizer.Utils.expand_ranges_from_destination_to_source(head, reference) == [
               {100, nil, 10}
             ]
    end

    test "head starts before reference and ends right before it" do
      head = [{10, nil, 5}]
      reference = [{25, 16, 10}]

      assert Fertilizer.Utils.expand_ranges_from_destination_to_source(head, reference) == [
               {10, nil, 5}
             ]
    end

    test "head starts before reference and ends right after it" do
      head = [{10, nil, 5}]
      reference = [{25, 14, 10}]

      assert Fertilizer.Utils.expand_ranges_from_destination_to_source(head, reference) == [
               {10, nil, 4},
               {25, nil, 1}
             ]
    end

    test "head starts right before end of reference and ends after it" do
      head = [{10, nil, 5}]
      reference = [{25, 5, 6}]

      assert Fertilizer.Utils.expand_ranges_from_destination_to_source(head, reference) == [
               {30, nil, 1},
               {11, nil, 4}
             ]
    end

    test "another example" do
      head = [{74, nil, 14}]
      reference = [{45, 77, 23}, {81, 45, 19}, {68, 64, 13}]

      assert Fertilizer.Utils.expand_ranges_from_destination_to_source(head, reference) == [
               {78, nil, 3},
               {45, nil, 11}
             ]
    end

    test "one more example" do
      head = [{78, nil, 3}, {45, nil, 11}]
      reference = [{0, 69, 1}, {1, 0, 69}]

      assert Fertilizer.Utils.expand_ranges_from_destination_to_source(head, reference) == [
               {78, nil, 3},
               {46, nil, 11}
             ]
    end

    test "no reference ranges" do
      head = [{1, nil, 2}]
      reference = []

      assert Fertilizer.Utils.expand_ranges_from_destination_to_source(head, reference) == [
               {1, nil, 2}
             ]
    end

    test "no overlapping reference ranges" do
      head = [{1, nil, 2}]
      reference = [{3, 4, 5}]

      assert Fertilizer.Utils.expand_ranges_from_destination_to_source(head, reference) == [
               {1, nil, 2}
             ]
    end

    test "starts before and ends within reference range" do
      head = [{2, nil, 7}]
      reference = [{3, 4, 10}]

      assert Fertilizer.Utils.expand_ranges_from_destination_to_source(head, reference) == [
               {2, nil, 2},
               {3, nil, 5}
             ]
    end

    test "starts within and ends after reference range" do
      head = [{9, nil, 7}]
      reference = [{3, 4, 10}]

      assert Fertilizer.Utils.expand_ranges_from_destination_to_source(head, reference) == [
               {8, nil, 5},
               {14, nil, 2}
             ]
    end

    test "starts before and ends after reference range" do
      head = [{9, nil, 35}]
      reference = [{3, 14, 10}]

      assert Fertilizer.Utils.expand_ranges_from_destination_to_source(head, reference) == [
               {9, nil, 5},
               {3, nil, 10},
               {24, nil, 20}
             ]
    end

    test "is completely within range" do
      head = [{45, nil, 11}]
      reference = [{1, 0, 69}]

      assert Fertilizer.Utils.expand_ranges_from_destination_to_source(head, reference) == [
               {46, nil, 11}
             ]
    end
  end
end
