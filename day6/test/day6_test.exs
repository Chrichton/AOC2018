defmodule Day6Test do
  use ExUnit.Case

  test "parse_coordinate" do
    assert Day6.parse_coordinate("1, 6") == {1, 6}
  end

  test "read_input" do
    actual = Day6.read_input("sample1")

    assert actual == [{1, 1}, {1, 6}, {8, 3}, {3, 4}, {5, 5}, {8, 9}]
  end

  test "inner_points" do
    actual = Day6.inner_points([{3, 4}, {1, 2}])

    assert actual == [{1, 2}, {1, 3}, {1, 4}, {2, 2}, {2, 3}, {2, 4}, {3, 2}, {3, 3}, {3, 4}]
  end

  test "manhattan_distance" do
    actual = Day6.manhattan_distance({3, 2}, {1, 5})

    assert actual == 5
  end

  test "create_distances_map" do
    actual = Day6.create_distances_map({1, 2}, [{3, 5}, {0, 1}])

    assert actual == %{{0, 1} => 2, {3, 5} => 5}
  end

  test "create_distances_maps" do
    actual = Day6.create_distances_maps([{1, 0}, {0, 1}], [{3, 5}, {0, 1}])

    assert actual == %{
             {0, 1} => %{{0, 1} => 0, {3, 5} => 7},
             {1, 0} => %{{0, 1} => 2, {3, 5} => 7}
           }
  end

  test "find_nearest_point" do
    points = [{0, 0}, {0, 4}]
    inner_points = Day6.inner_points(points)
    distances_maps = Day6.create_distances_maps(points, inner_points)

    actual = Day6.find_nearest_point({0, 1}, distances_maps)
    assert actual == {0, 0}

    actual = Day6.find_nearest_point({0, 2}, distances_maps)
    assert actual == nil
  end

  test "create_islands" do
    # points = [{1, 1}, {1, 6}, {8, 3}, {3, 4}, {5, 5}, {8, 9}]
    points = [{0, 0}, {0, 4}]
    inner_points = Day6.inner_points(points)
    distances_maps = Day6.create_distances_maps(points, inner_points)

    actual =
      Day6.create_islands(
        distances_maps,
        inner_points
      )

    assert actual == %{
             {0, 0} => {0, 0},
             {0, 1} => {0, 0},
             {0, 2} => {-1, -1},
             {0, 3} => {0, 4},
             {0, 4} => {0, 4}
           }
  end

  test "sample1" do
    assert Day6.solve1("sample1") == 10
  end

  test "star1" do
    assert Day6.solve1("star1") == 10886
  end

  test "sample2" do
    assert Day6.solve2("sample1") == 4
  end

  test "star2" do
    assert Day6.solve2("star1") == 4684
  end
end
