defmodule CamelCards.ParserTest do
  use ExUnit.Case

  describe "parse/1" do
    test "returns correct data" do
      assert CamelCards.Parser.parse("32T3K 765") == {{?3, ?2, ?T, ?3, ?K}, 765}
    end
  end
end
