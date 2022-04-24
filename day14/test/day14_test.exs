defmodule Day14Test do
  use ExUnit.Case

  test "calc_index" do
    assert Day14.calc_index([3, 7, 1, 0], 0) == 4
    assert Day14.calc_index([3, 7, 1, 0], 1) == 3
  end

  test "next_step" do
    actual = Day14.next_step([3, 7], 0, 1)

    assert actual == {[3, 7, 1, 0], 4, 3}
  end
end
