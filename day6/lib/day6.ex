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
    {min_x, max_x, min_y, max_y} = dimensions(points)

    for x <- min_x..max_x,
        y <- min_y..max_y do
      {x, y}
    end
  end

  def dimensions(points) do
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

    {min_x, max_x, min_y, max_y}
  end

  def islands(distances_maps, inner_points) do
    inner_points
    |> Enum.reduce(Map.new(), fn {x, y}, map ->
      case find_nearest_point({x, y}, distances_maps) do
        nil -> Map.put(map, {x, y}, {-1, -1})
        {x_nearest, y_nearest} -> Map.put(map, {x, y}, {x_nearest, y_nearest})
      end
    end)
  end

  def find_nearest_point({x, y} = _point, distances_maps) do
    points_distances =
      distances_maps
      |> Enum.map(fn {key, distance_map} ->
        {key, distance_map[{x, y}]}
      end)

    if duplicate_distances?(points_distances) do
      nil
    else
      points_distances
      |> Enum.sort_by(fn {{_xs, _ys}, value} -> value end)
      |> hd()
      |> elem(0)
    end
  end

  def duplicate_distances?(points_distances) do
    distances =
      points_distances
      |> Enum.map(fn {{_x, _y}, distance} -> distance end)

    distances != distances |> Enum.uniq()
  end

  def distances_maps(points, inner_points) do
    points
    |> Enum.reduce(Map.new(), fn {x, y}, map ->
      Map.put(map, {x, y}, distances_map({x, y}, inner_points))
    end)
  end

  def distances_map({x, y} = _point, inner_points) do
    inner_points
    |> Enum.reduce(Map.new(), fn {xi, yi}, map ->
      distance = manhattan_distance({x, y}, {xi, yi})
      Map.put(map, {xi, yi}, distance)
    end)
  end

  def manhattan_distance({x1, y1}, {x2, y2}), do: abs(x1 - x2) + abs(y1 - y2)

  def border_point?(
        {x, y} = _point,
        {min_x, max_x, min_y, max_y} = _dimensions
      ),
      do: x == min_x or x == max_x or y == min_y or y == max_y

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
