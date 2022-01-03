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

  def manhattan_distance({x1, y1}, {x2, y2}), do: abs(x1 - x2) - abs(y1 - y2)

  @spec inner_points([{integer(), integer()}]) :: [{integer(), integer()}]
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
