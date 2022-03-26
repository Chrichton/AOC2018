defmodule Day12Test do
  use ExUnit.Case

  test "parse_rule" do
    actual = Day12.parse_rule("...## => #")

    assert actual == %Day12.Rule{
             prev_prev: false,
             prev: false,
             current: false,
             next: true,
             next_next: true,
             result: true
           }
  end

  test "read_input" do
    {pots, rules} = Day12.read_input("sample")

    assert pots == MapSet.new([0, 3, 5, 8, 9, 16, 17, 18, 22, 23, 24])
    assert Enum.count(rules) == 14
  end

  test "sample" do
  end

  test "star" do
  end
end
