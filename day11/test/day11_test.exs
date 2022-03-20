defmodule Day11Test do
  use ExUnit.Case

  test "extract_hundreds_digit" do
    assert Day11.extract_hundreds_digit(0) == 0
    assert Day11.extract_hundreds_digit(1023) == 0
    assert Day11.extract_hundreds_digit(123) == 1
    assert Day11.extract_hundreds_digit(1234) == 2
  end

  test "calc_power_level" do
    assert Day11.calc_power_level({3, 5}, 8) == 4
    assert Day11.calc_power_level({122, 79}, 57) == -5
    assert Day11.calc_power_level({217, 196}, 39) == 0
    assert Day11.calc_power_level({101, 153}, 71) == 4
  end

  test "samples" do
    assert Day11.solve1(18) == {33, 45}
    assert Day11.solve1(42) == {21, 61}
  end

  test "solve1" do
    assert Day11.solve1(5468) == {243, 64}
  end
end
