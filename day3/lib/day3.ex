defmodule Day3 do
  def solve1(filename) do
    filename
    |> read_input()
  end

  def solve2(filename) do
    filename
    |> read_input()
  end

  def read_input(filename) do
    File.read!(filename)
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      String.split(line, " ", trim: true)
      |> then(fn [_id, _ ,positon, size] ->
        point = positon
        |> String.slice(0, String.length(positon) - 1)
        |> String.split(",")
        |> then(fn [x,y] ->
          {String.to_integer(x),
          String.to_integer(y)}
        end)

        [width, height] = size
        |> String.split("x")
        |> then(fn [x,y] ->
          [String.to_integer(x),
          String.to_integer(y)]
        end)

        {point, width, height}
      end)
    end)
  end
end
