defmodule Day3Test do
  use ExUnit.Case

  test "read input" do
    actual = Day3.read_input("sample1")

    assert actual == nil
  end

  test "sample1" do
    assert Day3.solve1("sample1") == 4
  end

  test "star1" do
    assert Day3.solve1("star1") == 111485
  end

  test "sample2" do
    assert Day3.solve1("sample2") == 12
  end

  test "star2" do
    assert Day3.solve2("star2") == "lufjygedpvfbhftxiwnaorzmq"
  end
end
