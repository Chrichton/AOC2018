defmodule Day14Test do
  use ExUnit.Case

  test "calc_index" do
    assert Day14.calc_index([3, 7, 1, 0], 0) == 0
    assert Day14.calc_index([3, 7, 1, 0], 1) == 1

    assert Day14.calc_index([3, 7, 1, 0, 1, 0, 1], 4) == 6
    assert Day14.calc_index([3, 7, 1, 0, 1, 0, 1], 3) == 4
  end

  test "next_step" do
    actual = Day14.next_step([3, 7], 0, 1)
    assert actual == {[3, 7, 1, 0], 0, 1}

    actual = Day14.next_step([3, 7, 1, 0], 0, 1)
    assert actual == {[3, 7, 1, 0, 1, 0], 4, 3}

    actual = Day14.next_step([3, 7, 1, 0, 1, 0], 4, 3)
    assert actual == {[3, 7, 1, 0, 1, 0, 1], 6, 4}
  end

  test "score_after_recipies" do
    actual = Day14.score_after_recipies([3, 7], 0, 1, 9)

    assert actual == [5, 1, 5, 8, 9, 1, 6, 7, 7, 9]
  end
end
