defmodule Day1ValimTest do
  use ExUnit.Case
  doctest Day1

  test "sample first star" do
    assert Day1Valim.solve1("sample") == 3
  end

  test "first star" do
    assert Day1Valim.solve1("star") == 592
  end

  test "sample second star" do
    assert Day1Valim.solve2("sample") == 2
  end

  test "second star" do
    assert Day1Valim.solve2("star") == 241
  end
end
