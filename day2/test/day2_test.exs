defmodule Day2Test do
  use ExUnit.Case
  doctest Day2

  test "repeats" do
    assert Day2.repeats("abccbab", 2) == 2
    assert Day2.repeats("abccbab", 3) == 1
  end

  test "box_repeat_count" do
    assert Day2.box_repeat_count("abccbab", 2) == 1
    assert Day2.box_repeat_count("abccbab", 3) == 1
  end

  test "sample1" do
    assert Day2.solve1("sample1") == 12
  end

  test "star1" do
    assert Day2.solve1("star1") == 4712
  end

  test "common_string" do
    assert Day2.differences_string("abcde", "axcye") == "ace"
    assert Day2.differences_string("fghij", "fguij") == "fgij"
  end

  test "star2" do
    assert Day2.solve2("star2") == "lufjygedpvfbhftxiwnaorzmq"
  end
end
