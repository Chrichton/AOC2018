defmodule Day10Test do
  use ExUnit.Case

  @input """
  position=<-50310,  10306> velocity=< 5, -1>
  position=< 10277, -30099> velocity=<-1,  3>
  """

  test "parse_input" do
    expected = [
      {-50310, 10306, 5, -1},
      {10277, -30099, -1, 3}
    ]

    assert Day10.parse_input(@input) == expected
  end

  test "to_list" do
    lines = Day10.parse_input(@input)

    actual = Day10.to_list(lines)

    expected = [
      {{-50310, 10306}, {5, -1}},
      {{10277, -30099}, {-1, 3}}
    ]

    assert actual == expected
  end

  test "next_step" do
    list =
      @input
      |> Day10.parse_input()
      |> Day10.to_list()

    actual = Day10.next_step(list)

    expected = [
      {{-50310 + 5, 10306 - 1}, {5, -1}},
      {{10277 - 1, -30099 + 3}, {-1, 3}}
    ]

    assert actual == expected
  end

  test "sample1" do
    list =
      Day10.read_input("sample")
      |> Day10.to_list()
      |> Day10.next_step()
      |> Day10.next_step()
      |> Day10.next_step()

    expected = """
    #...#..###
    #...#...#.
    #...#...#.
    #####...#.
    #...#...#.
    #...#...#.
    #...#...#.
    #...#..###\
    """

    points = Day10.positons(list)

    actual = Day10.visualize_puzzle(points)

    assert actual == expected
  end

  test "star" do
    list =
      Day10.read_input("star")
      |> Day10.to_list()

    result_list =
      0..10100
      |> Enum.reduce(list, fn step, acc ->
        Day10.next_step(acc)
      end)

    points = Day10.positons(result_list)
    actual = Day10.visualize_puzzle(points)

    expected = """
    .####...#####...######..#####...#####...#####...######.....###
    #....#..#....#..#.......#....#..#....#..#....#..#...........#.
    #.......#....#..#.......#....#..#....#..#....#..#...........#.
    #.......#....#..#.......#....#..#....#..#....#..#...........#.
    #.......#####...#####...#####...#####...#####...#####.......#.
    #..###..#.......#.......#.......#.......#.......#...........#.
    #....#..#.......#.......#.......#.......#.......#...........#.
    #....#..#.......#.......#.......#.......#.......#.......#...#.
    #...##..#.......#.......#.......#.......#.......#.......#...#.
    .###.#..#.......######..#.......#.......#.......######...###..\
    """

    assert actual == expected
  end

  @tag :skip
  test "sample2" do
    assert Day10.solve2("sample") == nil
  end

  @tag :skip
  test "star2" do
    assert Day10.solve2("star") == 25416
  end
end
