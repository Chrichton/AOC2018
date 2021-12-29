defmodule Day3 do
  def solve1(filename) do
    filename
    |> read_input()
    |> calc_square_inches()
  end

  def calc_square_inches(points_claim_ids_and_sizes) do
    points_claim_ids_and_sizes
    |> Enum.reduce(Map.new(), fn {{_x, _y} = point, claim_id, width, height}, map ->
      create_points_with_claim_id(point, claim_id, width, height)
      |> Enum.reduce(map, fn {{_x, _y} = point, _claim_id}, acc ->
        Map.update(acc, point, 1, fn existing_value ->
          existing_value + 1
        end)
      end)
    end)
    |> Map.values()
    |> Enum.filter(fn value -> value > 1 end)
    |> Enum.count()
  end

  def create_points_with_claim_id({x, y}, claim_id, width, height) do
    for x <- x..(x + width - 1),
        y <- y..(y + height - 1) do
      {{x, y}, claim_id}
    end
  end

  def solve2(filename) do
    filename
    |> read_input()
    |> calc_square_inches2()
  end

  def calc_square_inches2(points_claim_ids_and_sizes) do
    points_claim_ids_and_sizes
    |> Enum.reduce(Map.new(), fn {{_x, _y} = point, claim_id, width, height}, map ->
      create_points_with_claim_id(point, claim_id, width, height)
      |> Enum.reduce(map, fn {{_x, _y} = point, claim_id}, acc ->
        Map.update(acc, point, [claim_id], fn claim_ids ->
          [claim_id | claim_ids] |> Enum.uniq()
        end)
      end)
    end)
    |> Map.values()
    |> then(fn claim_ids ->
      overlapping_claim_ids =
        claim_ids
        |> Enum.filter(fn claim_ids -> Enum.count(claim_ids) > 1 end)
        |> Enum.flat_map(fn x -> x end)
        |> MapSet.new()

      remaining_claim_ids =
        claim_ids
        |> Enum.filter(fn claim_ids -> Enum.count(claim_ids) == 1 end)
        |> Enum.flat_map(fn x -> x end)
        |> MapSet.new()

      [claim_id] =
        MapSet.difference(remaining_claim_ids, overlapping_claim_ids)
        |> MapSet.to_list()

      claim_id
    end)
  end

  def read_input(filename) do
    File.read!(filename)
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      String.split(line, " ", trim: true)
      |> then(fn [claim_id, _, positon, size] ->
        claim_id =
          String.slice(claim_id, 1, String.length(claim_id) - 1)
          |> String.to_integer()

        point =
          positon
          |> String.slice(0, String.length(positon) - 1)
          |> String.split(",")
          |> then(fn [x, y] ->
            {String.to_integer(x), String.to_integer(y)}
          end)

        [width, height] =
          size
          |> String.split("x")
          |> then(fn [x, y] ->
            [String.to_integer(x), String.to_integer(y)]
          end)

        {point, claim_id, width, height}
      end)
    end)
  end
end
