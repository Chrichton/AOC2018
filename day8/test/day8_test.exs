defmodule Day8Test do
  use ExUnit.Case

  test "read_input" do
    actual = Day8.read_input("sample")

    expected = [2, 3, 0, 3, 10, 11, 12, 1, 1, 0, 1, 99, 2, 1, 1, 2]

    assert actual == expected
  end

  test "sample1" do
    assert Day8.solve1("sample") == 138
  end

  test "star1" do
    assert Day8.solve1("star") == 40701
  end

  test "sample2" do
    assert Day8.solve2("sample") == 66
  end

  test "star2" do
    assert Day8.solve2("star") == 25416
  end
end
