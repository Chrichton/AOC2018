defmodule Day4Test do
  use ExUnit.Case

  test "parse_minutes" do
    actual = Day4.parse_minutes("[1518-11-01 00:05] falls asleep")

    assert actual == 5
  end

  test "read input" do
    actual = Day4.read_input("sample1")

    assert actual == %{
             10 => [24..28, 30..54, 5..24],
             99 => [45..54, 36..45, 40..49]
           }
  end

  test "id_with_longest_sleep_time" do
    map = %{
      10 => [24..28, 30..54, 5..24],
      99 => [45..54, 36..45, 40..49]
    }

    actual = Day4.id_with_longest_sleep_time(map)

    assert actual == {10, [24..28, 30..54, 5..24]}
  end

  test "longest_minute" do
    actual = Day4.longest_minute([24..28, 30..54, 5..24])

    assert actual == 24
  end

  test "sample1" do
    assert Day4.solve1("sample1") == 240
  end

  test "star1" do
    assert Day4.solve1("star1") == 8950
  end

  test "sample2" do
    assert Day4.solve2("sample1") == 4455
  end

  test "star2" do
    assert Day4.solve2("star1") == 78452
  end
end
