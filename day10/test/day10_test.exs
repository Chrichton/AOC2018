defmodule Day10Test do
  use ExUnit.Case

  @input """
  position=<-50310,  10306> velocity=< 5, -1>
  position=< 10277, -30099> velocity=<-1,  3>
  """

  test "parse_input" do
    expected = [
      {-50310, 10306, 5, -1},
      {10277, -30099, -1, 3}
    ]

    assert Day10.parse_input(@input) == expected
  end

  test "to_map" do
    lines = Day10.parse_input(@input)

    actual = Day10.to_map(lines)

    expected = %{
      {-50310, 10306} => {5, -1},
      {10277, -30099} => {-1, 3}
    }

    assert actual == expected
  end

  test "next_step" do
    map =
      @input
      |> Day10.parse_input()
      |> Day10.to_map()

    actual = Day10.next_step(map)

    expected = %{
      {-50310 + 5, 10306 - 1} => {5, -1},
      {10277 - 1, -30099 + 3} => {-1, 3}
    }

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
