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

  test "rules_result" do
    {pots, rules} = Day12.read_input("sample")

    assert Day12.rules_result(rules, pots, 0)
    refute Day12.rules_result(rules, pots, 1)
    refute Day12.rules_result(rules, pots, 2)
    refute Day12.rules_result(rules, pots, 3)
    assert Day12.rules_result(rules, pots, 4)
    refute Day12.rules_result(rules, pots, 5)
  end

  test "sample" do
    actual = Day12.solve1("sample", 1..20)

    assert actual == 325
  end

  test "star1" do
    actual = Day12.solve1("star", 1..20)

    assert actual == 2995
  end

  test "star2" do
    # actual = Day12.solve1("star", 1..50_000_000_000)

    # assert actual == ?

    # generation: 161, sum: 11890
    # generation: 162, sum: 12130

    # 12130 73
    # 12203 73
    # 12276
    # 12349
    # 12422
    # 12495
    # 12568
    # 12641
    # 12714
    # 12787
    # 12860
    # 12933

    # sum(generation) = 12130 + (generation - 162) * 73

    # 3650000000304 too low
  end
end
