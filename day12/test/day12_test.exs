defmodule Day12Test do
  use ExUnit.Case

  test "parse_input" do
    actual = Day12.parse_input(["#..#.#..##......###...###"])

    assert actual == MapSet.new([0, 3, 5, 8, 9, 16, 17, 18, 22, 23, 24])
  end

  test "read_input" do
  end

  test "sample1" do
  end

  test "star" do
  end
end
