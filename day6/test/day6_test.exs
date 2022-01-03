defmodule Day6Test do
  use ExUnit.Case

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
