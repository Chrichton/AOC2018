defmodule Day5Test do
  use ExUnit.Case

  test "cancel_out?" do
    assert Day5.cancel_out?("a", "A")
    assert Day5.cancel_out?("A", "a")

    refute Day5.cancel_out?("A", "A")
    refute Day5.cancel_out?("a", "a")
  end

  test "cancel_out" do
    actual = Day5.cancel_out("dabAcCaCBAcCcaDA")

    assert actual == "dabCBAcaDA"
  end

  test "sample1" do
    assert Day5.solve1("sample1") == 10
  end

  test "star1" do
    assert Day5.solve1("star1") == 10886
  end

  test "sample2" do
    assert Day5.solve2("sample1") == 0
  end

  test "star2" do
    assert Day5.solve2("star1") == 0
  end
end
