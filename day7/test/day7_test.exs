defmodule Day7Test do
  use ExUnit.Case

  test "read_input" do
    actual = Day7.read_input("sample")

    expected = [
      {"C", "A"},
      {"C", "F"},
      {"A", "B"},
      {"A", "D"},
      {"B", "E"},
      {"D", "E"},
      {"F", "E"}
    ]
  end

  test "sample1" do
    assert Day7.solve1("sample") == 17
  end

  test "star1" do
    assert Day7.solve1("star") == 3969
  end

  test "sample2" do
    assert Day7.solve2("sample") == 17
  end

  test "star2" do
    assert Day7.solve2("star") == 3969
  end
end
