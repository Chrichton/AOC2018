defmodule Day10Test do
  use ExUnit.Case

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
