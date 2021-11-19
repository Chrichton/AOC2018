defmodule Day1Test do
  use ExUnit.Case
  doctest Day1

  test "sample first star" do
    assert Day1.solve1("sample") == 3
  end

  test "first star" do
    assert Day1.solve1("star") == 592
  end
end
