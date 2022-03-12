defmodule Day10Test do
  use ExUnit.Case

  test "parse_input" do
    input = """
    position=<-50310,  10306> velocity=< 5, -1>
    position=< 10277, -30099> velocity=<-1,  3>
    """

    expected = [
      {-50310, 10306, 5, -1},
      {10277, -30099, -1, 3}
    ]

    assert Day10.parse_input(input) == expected
  end

  @tag :skip
  test "read_input" do
    actual = Day10.read_input("sample")

    expected = nil

    assert actual == expected
  end

  @tag :skip
  test "sample1" do
    assert Day10.solve1("sample") == nil
  end

  @tag :skip
  test "star1" do
    assert Day10.solve1("star") == nil
  end

  @tag :skip
  test "sample2" do
    assert Day10.solve2("sample") == nil
  end

  @tag :skip
  test "star2" do
    assert Day10.solve2("star") == 25416
  end
end
