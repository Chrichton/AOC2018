defmodule Day11Test do
  use ExUnit.Case

  test "extract_hundreds_digit" do
    assert Day11.extract_hundreds_digit(0) == 0
    assert Day11.extract_hundreds_digit(1023) == 0
    assert Day11.extract_hundreds_digit(123) == 1
    assert Day11.extract_hundreds_digit(1234) == 2
  end

  @tag :skip
  test "solve1" do
    assert Day11.solve1(5468) == nil
  end
end
