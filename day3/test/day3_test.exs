defmodule Day3Test do
  use ExUnit.Case

  test "read input" do
    actual = Day3.read_input("sample1")

    assert actual == [{{1, 3}, 1, 4, 4}, {{3, 1}, 2, 4, 4}, {{5, 5}, 3, 2, 2}]
  end

  test "sample1" do
    assert Day3.solve1("sample1") == 4
  end

  test "star1" do
    assert Day3.solve1("star1") == 111_485
  end

  test "sample2" do
    assert Day3.solve2("sample1") == 3
  end

  test "star2" do
    assert Day3.solve2("star1") == 113
  end
end
