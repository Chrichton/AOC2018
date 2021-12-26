defmodule Day4Test do
  use ExUnit.Case

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
