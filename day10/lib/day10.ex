defmodule Day10 do
  import NimbleParsec

  def solve1(filename) do
    filename
    |> read_input()
  end

  def read_input(filename) do
    File.read!(filename)
    |> String.split("\n")
    |> Enum.map(&parsec_header/1)
  end

  def visualize_puzzle(points) do
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

    for y <- min_y..max_y do
      for x <- min_x..max_x do
        if MapSet.member?(points, {x, y}),
          do: "#",
          else: "."
      end
      |> Enum.join()
    end
    |> Enum.join("\n")
  end

  def parse_header(string) do
    {:ok, [child_node_count, metadata_count], _, _, _, _} = parsec_header(string)

    {child_node_count, metadata_count}
  end

  # second star ---------------

  def solve2(filename) do
    filename
    |> read_input()
  end

  # Parsing ----------------------------------------------------------------

  defparsecp(
    :parsec_header,
    integer(min: 1)
    |> ignore(string(" "))
    |> integer(min: 1)
    |> ignore(string(" "))
  )
end
