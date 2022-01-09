defmodule Day6 do
  import NimbleParsec

  def solve1(filename) do
    filename
    |> read_input()
    |> islands()
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

  def islands(points) do
    dimensions = Day6.dimensions(points)
    inner_points = Day6.inner_points(points)
    distances_maps = Day6.distances_maps(points, inner_points)
    coordinates_map = Day6.coordinates_view(distances_maps, inner_points)

    # visualize_puzzle(coordinates_map, dimensions)
    # |> IO.puts()

    coordinates_map
    |> Map.filter(fn {point, value} ->
      value != nil && not border_point?(point, dimensions)
    end)
    |> Map.values()
    |> Enum.frequencies()
    |> Map.values()
    |> IO.inspect()
    |> Enum.max()
  end

  def coordinates_view(distances_maps, inner_points) do
    inner_points
    |> Enum.reduce(Map.new(), fn {x, y}, map ->
      case find_nearest_point({x, y}, distances_maps) do
        nil -> Map.put(map, {x, y}, nil)
        {x_nearest, y_nearest} -> Map.put(map, {x, y}, {x_nearest, y_nearest})
      end
    end)
  end

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

  # def border_points({min_x, max_x, min_y, max_y} = dimensions) do
  #   for x <- min_x..max_x,
  #     for y <- min_y..max_y,
  #       border_point?({x, y}, dimensions),
  #       do: {x, y}
  # end

  def border_point?(
        {x, y} = _point,
        {min_x, max_x, min_y, max_y} = _dimensions
      ),
      do: x == min_x or x == max_x or y == min_y or y == max_y

  def visualize_puzzle(coordinates_map, {min_x, max_x, min_y, max_y}) do
    for y <- min_y..max_y do
      for x <- min_x..max_x do
        (coordinates_map[{x, y}] |> inspect()) <> " "
      end
      |> Enum.join()
    end
    |> Enum.join("\n")
  end

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
