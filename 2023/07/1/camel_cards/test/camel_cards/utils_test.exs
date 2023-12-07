defmodule CamelCards.UtilsTest do
  use ExUnit.Case

  describe "hand_type/1" do
    test "correctly identifies five of a kind" do
      assert CamelCards.Utils.hand_type({?A, ?A, ?A, ?A, ?A}) == :five_of_a_kind
    end

    test "correctly identifies four of a kind" do
      assert CamelCards.Utils.hand_type({?A, ?A, ?8, ?A, ?A}) == :four_of_a_kind
    end

    test "correctly identifies full house" do
      assert CamelCards.Utils.hand_type({?2, ?3, ?3, ?3, ?2}) == :full_house
    end

    test "correctly identifies three of a kind" do
      assert CamelCards.Utils.hand_type({?T, ?T, ?T, ?9, ?8}) == :three_of_a_kind
    end

    test "correctly identifies two pair" do
      assert CamelCards.Utils.hand_type({?2, ?3, ?4, ?3, ?2}) == :two_pair
    end

    test "correctly identifies one pair" do
      assert CamelCards.Utils.hand_type({?A, ?2, ?3, ?A, ?4}) == :one_pair
    end

    test "correctly identifies high card" do
      assert CamelCards.Utils.hand_type({?2, ?3, ?4, ?5, ?6}) == :high_card
    end
  end
end
