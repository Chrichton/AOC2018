defmodule Day9Test do
  use ExUnit.Case

  test "read_input" do
    expected = {10, 1618}

    assert Day9.read_input("sample") == expected
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

  test "place_marble" do
    assert Day9.place_marble(1, [0], 0, nil) == {[0, 1], 1, nil}
    assert Day9.place_marble(2, [0, 1], 1, nil) == {[0, 2, 1], 1, nil}
    assert Day9.place_marble(3, [0, 2, 1], 1, nil) == {[0, 2, 1, 3], 3, nil}
    assert Day9.place_marble(4, [0, 2, 1, 3], 3, nil) == {[0, 4, 2, 1, 3], 1, nil}
  end

  test "pop_marble" do
    assert Day9.pop_marble([1, 2, 3, 4, 5, 6, 7, 8], 7) == {1, [2, 3, 4, 5, 6, 7, 8], 0}
    assert Day9.pop_marble([1, 2, 3, 4, 5, 6, 7, 8], 6) == {8, [1, 2, 3, 4, 5, 6, 7], 6}
  end

  test "winning_score" do
    assert Day9.winning_score({9, 25}) == 32
    assert Day9.winning_score({10, 1618}) == 8317
    assert Day9.winning_score({17, 1104}) == 2764
    assert Day9.winning_score({21, 6111}) == 54718
    assert Day9.winning_score({30, 5807}) == 37305

    # 202 too little
    assert Day9.winning_score({13, 7999}) == 146_373
  end

  test "sample1" do
    assert Day9.solve1("sample") == 8317
  end

  test "star1" do
    assert Day9.solve1("star") == 418_237
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
