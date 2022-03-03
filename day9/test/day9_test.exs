defmodule Day9Test do
  use ExUnit.Case

  test "read_input" do
    expected = {10, 1618, 8317}
  end

  test "marble_no_player_no_pairs" do
    expected = [
      {1, 1},
      {2, 2},
      {3, 3},
      {4, 4},
      {5, 5},
      {6, 6},
      {7, 7},
      {8, 8},
      {9, 9},
      {10, 1},
      {11, 2},
      {12, 3},
      {13, 4},
      {14, 5},
      {15, 6},
      {16, 7},
      {17, 8},
      {18, 9},
      {19, 1},
      {20, 2},
      {21, 3},
      {22, 4},
      {23, 5},
      {24, 6},
      {25, 7}
    ]

    assert Day9.marble_no_player_no_pairs(25, 9) == expected
  end

  @tag :skip
  test "sample1" do
    assert Day9.solve1("sample") == nil
  end

  @tag :skip
  test "star1" do
    assert Day9.solve1("star") == nil
  end

  @tag :skip
  test "sample2" do
    assert Day9.solve2("sample") == nil
  end

  @tag :skip
  test "star2" do
    assert Day9.solve2("star") == nil
  end
end
