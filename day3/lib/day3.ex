defmodule Day3 do
  def solve1(filename) do
    filename
    |> read_input()
    |> calc_square_inches()
  end

  def calc_square_inches(points_and_sizes) do
    points_and_sizes
    |> Enum.reduce(Map.new(), fn {{_x,_y} = point, width, height}, map ->
      create_points(point, width, height)
      |> Enum.reduce(map, fn {_x,_y} = point, acc ->
        Map.update(acc, point, 1, fn existing_value ->
          existing_value + 1
        end)
      end)
    end)
    |> Map.values()
    |> Enum.filter(fn value -> value > 1 end)
    |> Enum.count()
  end

  def create_points({x,y}, width, height) do
    for x <- x..(x + width - 1) do
      for y <- y..(y + height - 1) do
        {x,y}
      end
    end
    |> Enum.flat_map(fn x -> x end)
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
