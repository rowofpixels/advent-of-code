defmodule TuningTroubleTest do
  use ExUnit.Case

  describe "find_packet_marker/1" do
    test "returns 7 for mjqjpqmgbljsphdztnvjfqwrcgsmlb" do
      assert TuningTrouble.find_packet_marker("mjqjpqmgbljsphdztnvjfqwrcgsmlb") == 7
    end

    test "returns 5 for bvwbjplbgvbhsrlpgdmjqwftvncz" do
      assert TuningTrouble.find_packet_marker("bvwbjplbgvbhsrlpgdmjqwftvncz") == 5
    end

    test "returns 6 for nppdvjthqldpwncqszvftbrmjlhg" do
      assert TuningTrouble.find_packet_marker("nppdvjthqldpwncqszvftbrmjlhg") == 6
    end

    test "returns 10 for nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg" do
      assert TuningTrouble.find_packet_marker("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg") == 10
    end

    test "returns 11 for zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw" do
      assert TuningTrouble.find_packet_marker("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw") == 11
    end
  end

  describe "find_message_marker/1" do
    test "returns 19 for mjqjpqmgbljsphdztnvjfqwrcgsmlb" do
      assert TuningTrouble.find_message_marker("mjqjpqmgbljsphdztnvjfqwrcgsmlb") == 19
    end

    test "returns 23 for bvwbjplbgvbhsrlpgdmjqwftvncz" do
      assert TuningTrouble.find_message_marker("bvwbjplbgvbhsrlpgdmjqwftvncz") == 23
    end

    test "returns 23 for nppdvjthqldpwncqszvftbrmjlhg" do
      assert TuningTrouble.find_message_marker("nppdvjthqldpwncqszvftbrmjlhg") == 23
    end

    test "returns 29 for nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg" do
      assert TuningTrouble.find_message_marker("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg") == 29
    end

    test "returns 26 for zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw" do
      assert TuningTrouble.find_message_marker("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw") == 26
    end
  end
end
