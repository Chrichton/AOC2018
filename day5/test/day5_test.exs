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

  test "cancel_out_pairs" do
    actual = Day5.cancel_out_pairs()

    expected = [
      {"A", "a"},
      {"B", "b"},
      {"C", "c"},
      {"D", "d"},
      {"E", "e"},
      {"F", "f"},
      {"G", "g"},
      {"H", "h"},
      {"I", "i"},
      {"J", "j"},
      {"K", "k"},
      {"L", "l"},
      {"M", "m"},
      {"N", "n"},
      {"O", "o"},
      {"P", "p"},
      {"Q", "q"},
      {"R", "r"},
      {"S", "s"},
      {"T", "t"},
      {"U", "u"},
      {"V", "v"},
      {"W", "w"},
      {"X", "x"},
      {"Y", "y"},
      {"Z", "z"}
    ]

    assert actual == expected
  end

  test "cancel_out_pair" do
    actual = Day5.cancel_out_pair("dabAcCaCBAcCcaDA", {"A", "a"})

    assert actual == "dbCBcD"
  end

  test "sample2" do
    assert Day5.solve2("sample1") == nil
  end

  test "star2" do
    assert Day5.solve2("star1") == nil
  end
end
