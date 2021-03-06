defmodule Day10 do
  import NimbleParsec

  def solve1(filename) do
    filename
    |> read_input()
    |> to_list()
  end

  def read_input(filename) do
    File.read!(filename)
    |> parse_input()
  end

  def to_list(lines) do
    lines
    |> Enum.map(fn {x, y, vx, vy} ->
      {{x, y}, {vx, vy}}
    end)
  end

  def positons(list) do
    list
    |> Enum.map(fn {{x, y}, {_vx, _vy}} ->
      {x, y}
    end)
  end

  def next_step(list) do
    list
    |> Enum.map(fn {{x, y}, {vx, vy}} ->
      {{x + vx, y + vy}, {vx, vy}}
    end)
  end

  def visualize_puzzle(points) do
    points = MapSet.new(points)

    min_x =
      points
      |> Enum.min_by(fn {x, _y} ->
        x
      end)
      |> elem(0)

    max_x =
      points
      |> Enum.max_by(fn {x, _y} ->
        x
      end)
      |> elem(0)

    min_y =
      points
      |> Enum.min_by(fn {_x, y} ->
        y
      end)
      |> elem(1)

    max_y =
      points
      |> Enum.max_by(fn {_x, y} ->
        y
      end)
      |> elem(1)

    if max_y - min_y < 50 and max_x - min_x < 100 do
      for(y <- min_y..max_y) do
        for x <- min_x..max_x do
          if MapSet.member?(points, {x, y}),
            do: "#",
            else: "."
        end
        |> Enum.join()
      end
      |> Enum.join("\n")
    end
  end

  def parse_input(string) do
    {:ok, lines, _, _, _, _} = lines(string)

    lines
    |> Enum.map(&map_parsed_line/1)
  end

  def map_parsed_line([x, y, " ", vx, vy]) do
    [x, y, vx, vy]
    |> Enum.map(fn
      ["-", number] -> -number
      [number] -> number
    end)
    |> List.to_tuple()
  end

  # second star ---------------

  def solve2(filename) do
    filename
    |> read_input()
  end

  # Parsing ----------------------------------------------------------------

  value =
    choice([
      concat(string("-"), integer(min: 1)),
      integer(min: 1)
    ])
    |> wrap()

  pair =
    ignore(string("<"))
    |> eventually(value)
    |> eventually(ignore(string(",")))
    |> eventually(value)
    |> eventually(ignore(string(">")))

  position = ignore(string("position=")) |> concat(pair)
  # |> tag(:position)

  velocity = ignore(string("velocity=")) |> concat(pair)
  # |> tag(:velocity)

  line =
    position
    |> concat(string(" "))
    |> concat(velocity)
    |> wrap()

  optional_linebreak =
    "\n"
    |> string()
    |> optional()
    |> ignore()

  defparsecp(:line, line)
  defparsecp(:lines, times(parsec(:line) |> concat(optional_linebreak), min: 0))
end
