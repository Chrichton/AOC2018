defmodule Day4Test do
  use ExUnit.Case

  test "parse_minutes" do
    actual = Day4.parse_time("[1518-11-01 00:05] falls asleep")

    assert actual == ~N[1518-11-01 00:05:00]
  end

  test "calculate minutes" do
    asleep_time = ~N[1518-10-31 23:55:00]
    wakeup_time = ~N[1518-11-01 00:05:00]

    diff = Day4.calculate_minutes(asleep_time, wakeup_time)

    assert diff == 10
  end

  test "read input" do
    actual = Day4.read_input("sample1")

    assert actual == %{10 => [5, 25, 20], 99 => [10, 10, 10]}
  end

  test "sample1" do
    assert Day4.solve1("sample1") == 240
  end

  test "star1" do
    # too high
    assert Day4.solve1("star1") == 9487
  end

  test "sample2" do
    assert Day4.solve1("sample1") == 3
  end

  test "star2" do
    assert Day4.solve2("star1") == 113
  end
end
