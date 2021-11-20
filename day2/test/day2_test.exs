defmodule Day2Test do
  use ExUnit.Case
  doctest Day2

  test "repeats" do
    assert Day2.repeats("abccbab", 2) == 1
    assert Day2.repeats("abccbab", 3) == 1
  end

  test "sample1" do
    assert Day2.solve1("sample1") == 12
  end

  test "star1" do
    assert Day2.solve1("star1") == 4712
  end
end
