defmodule Day4Test do
  use ExUnit.Case

  test "parse_minutes" do
    actual = Day4.parse_minutes("[1518-11-01 00:05] falls asleep")

    assert actual == ~N[1518-11-01 00:05:00]
  end

  test "sample1" do
    assert Day4.solve1("sample1") == 4
  end

  test "star1" do
    assert Day4.solve1("star1") == 111485
  end

  test "sample2" do
    assert Day4.solve1("sample1") == 3
  end

  test "star2" do
    assert Day4.solve2("star1") == 113
  end
end
