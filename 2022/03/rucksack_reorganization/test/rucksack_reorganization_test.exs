defmodule RucksackReorganizationTest do
  use ExUnit.Case

  describe "total_priorities_for_duplicates/1" do
    test "returns 0 for an empty file" do
      file = """
      """

      assert RucksackReorganization.total_priorities_for_duplicates(String.split(file, "\n")) == 0
    end

    test "return 1 for a duplicate `a`" do
      file = """
      abac
      """

      assert RucksackReorganization.total_priorities_for_duplicates(String.split(file, "\n")) == 1
    end

    test "return 27 for a duplicate `A`" do
      file = """
      AbAc
      """

      assert RucksackReorganization.total_priorities_for_duplicates(String.split(file, "\n")) ==
               27
    end

    test "return 157 for given example" do
      file = """
      vJrwpWtwJgWrhcsFMMfFFhFp
      jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
      PmmdzqPrVvPwwTWBwg
      wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
      ttgJtRGJQctTZtZT
      CrZsJsPPZsGzwwsLwLmpwMDw
      """

      assert RucksackReorganization.total_priorities_for_duplicates(String.split(file, "\n")) ==
               157
    end
  end

  describe "total_priorities_for_badges/1" do
    test "returns 0 for an empty file" do
      file = """
      """

      assert RucksackReorganization.total_priorities_for_badges(String.split(file, "\n")) == 0
    end

    test "return 1 for badge `a`" do
      file = """
      abc
      ade
      afg
      """

      assert RucksackReorganization.total_priorities_for_badges(String.split(file, "\n")) == 1
    end

    test "return 70 for given example" do
      file = """
      vJrwpWtwJgWrhcsFMMfFFhFp
      jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
      PmmdzqPrVvPwwTWBwg
      wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
      ttgJtRGJQctTZtZT
      CrZsJsPPZsGzwwsLwLmpwMDw
      """

      assert RucksackReorganization.total_priorities_for_badges(String.split(file, "\n")) == 70
    end
  end
end
