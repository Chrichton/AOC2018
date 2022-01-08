defmodule Day6 do
  import NimbleParsec

  def solve1(filename) do
    filename
    |> read_input()
  end

  def parse_coordinate(string) do
    {:ok, [x, y], "", _, _, _} = parsec_coordinate(string)

    {x, y}
  end

  def inner_points(points) do
    min_x =
      points
      |> Enum.min_by(fn {x, _y} -> x end)
      |> elem(0)

    max_x =
      points
      |> Enum.max_by(fn {x, _y} -> x end)
      |> elem(0)

    min_y =
      points
      |> Enum.min_by(fn {_x, y} -> y end)
      |> elem(1)

    max_y =
      points
      |> Enum.max_by(fn {_x, y} -> y end)
      |> elem(1)

    for x <- min_x..max_x,
        y <- min_y..max_y do
      {x, y}
    end
  end

  def create_islands(distances_maps, inner_points) do
    inner_points
    |> Enum.reduce(Map.new(), fn {x, y}, map ->
      case find_nearest_point({x, y}, distances_maps) do
        nil -> Map.put(map, {x, y}, {-1, -1})
        {x_nearest, y_nearest} -> Map.put(map, {x, y}, {x_nearest, y_nearest})
      end
    end)
  end

  # {0, 1} => %{{0, 1} => 0, {3, 5} => 7},

  def find_nearest_point({x, y} = _point, distances_maps) do
    [{{x_nearest, y_nearest}, distance1} | [{{_x2, _y2}, distance2} | _rest]] =
      distances_maps
      |> Enum.map(fn {key, distance_map} ->
        {key, distance_map[{x, y}]}
      end)
      |> Enum.sort_by(fn {_key, value} -> value end)

    if distance1 == distance2,
      do: nil,
      else: {x_nearest, y_nearest}
  end

  def create_distances_maps(points, inner_points) do
    points
    |> Enum.reduce(Map.new(), fn {x, y}, map ->
      distances = create_distances_map({x, y}, inner_points)
      Map.put(map, {x, y}, distances)
    end)
  end

  def create_distances_map({x, y} = _point, inner_points) do
    inner_points
    |> Enum.reduce(Map.new(), fn {xi, yi}, map ->
      distance = manhattan_distance({x, y}, {xi, yi})
      Map.put(map, {xi, yi}, distance)
    end)
  end

  def manhattan_distance({x1, y1}, {x2, y2}), do: abs(x1 - x2) + abs(y1 - y2)

  def solve2(filename) do
    filename
    |> read_input()
  end

  def read_input(filename) do
    File.read!(filename)
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_coordinate/1)
  end

  # Parsing ----------------------------------------------------------------

  defparsecp(
    :parsec_coordinate,
    integer(min: 1)
    |> ignore(string(", "))
    |> integer(min: 1)
  )
end
