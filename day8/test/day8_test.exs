defmodule Day8Test do
  use ExUnit.Case

  test "read_input" do
    actual = Day8.read_input("sample")

    expected = [2, 3, 0, 3, 10, 11, 12, 1, 1, 0, 1, 99, 2, 1, 1, 2]

    assert actual == expected
  end

  test "sample1" do
    assert Day8.solve1("sample") == nil
  end

  @tag :skip
  test "star1" do
    assert Day8.solve1("star") == nil
  end

  @tag :skip
  test "sample2" do
    assert Day8.solve2("sample") == nil
  end

  @tag :skip
  test "star2" do
    assert Day8.solve2("star") == nil
  end
end
