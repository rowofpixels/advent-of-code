defmodule CampCleanupTest do
  use ExUnit.Case

  describe "count_contained_ranges/1" do
    test "returns 0 for an empty file" do
      file = """
      """

      assert CampCleanup.count_contained_ranges(String.split(file, "\n")) == 0
    end

    test "return 0 when no ranges are overlapped" do
      file = """
      1-2,3-4
      5-6,7-8
      """

      assert CampCleanup.count_contained_ranges(String.split(file, "\n")) == 0
    end

    test "return 0 when no ranges are fully contained" do
      file = """
      1-2,2-3
      5-6,6-7
      """

      assert CampCleanup.count_contained_ranges(String.split(file, "\n")) == 0
    end

    test "return 1 when 1 range is fully contained" do
      file = """
      1-2,2-3
      4-6,5-5
      7-8,8-9
      """

      assert CampCleanup.count_contained_ranges(String.split(file, "\n")) == 1
    end

    test "returns 2 for the given example" do
      file = """
      2-4,6-8
      2-3,4-5
      5-7,7-9
      2-8,3-7
      6-6,4-6
      2-6,4-8
      """

      assert CampCleanup.count_contained_ranges(String.split(file, "\n")) == 2
    end
  end

  describe "count_overlap_ranges/1" do
    test "returns 0 for an empty file" do
      file = """
      """

      assert CampCleanup.count_overlap_ranges(String.split(file, "\n")) == 0
    end

    test "return 0 when no ranges are overlapped" do
      file = """
      1-2,3-4
      5-6,7-8
      """

      assert CampCleanup.count_overlap_ranges(String.split(file, "\n")) == 0
    end

    test "returns 4 for the given example" do
      file = """
      2-4,6-8
      2-3,4-5
      5-7,7-9
      2-8,3-7
      6-6,4-6
      2-6,4-8
      """

      assert CampCleanup.count_overlap_ranges(String.split(file, "\n")) == 4
    end
  end
end
