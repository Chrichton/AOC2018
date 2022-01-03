defmodule Day6Test do
  use ExUnit.Case

  test "parse_coordinate" do
    assert Day6.parse_coordinate("1, 6") == {1, 6}
  end

  test "read_input" do
    actual = Day6.read_input("sample1")

    assert actual == [{1, 1}, {1, 6}, {8, 3}, {3, 4}, {5, 5}, {8, 9}]
  end

  test "inner_points" do
    actual = Day6.inner_points([{3, 4}, {1, 2}])

    assert actual == [{1, 2}, {1, 3}, {1, 4}, {2, 2}, {2, 3}, {2, 4}, {3, 2}, {3, 3}, {3, 4}]
  end

  test "sample1" do
    assert Day6.solve1("sample1") == 10
  end

  test "star1" do
    assert Day6.solve1("star1") == 10886
  end

  test "sample2" do
    assert Day6.solve2("sample1") == 4
  end

  test "star2" do
    assert Day6.solve2("star1") == 4684
  end
end
