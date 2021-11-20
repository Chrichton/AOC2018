defmodule Day2 do
  def solve1(filename) do
    filename
    |> read_input()
    |> solve_star1()
  end

  defp solve_star1(box_ids) do
    threes =
      box_ids
      |> Enum.map(&repeats(&1, 3))
      |> Enum.sum()

    twos =
      box_ids
      |> Enum.map(&repeats(&1, 2))
      |> Enum.sum()

    twos * threes
  end

  def repeats(string, repeat_count) do
    count =
      string
      |> String.codepoints()
      |> Enum.frequencies()
      |> Map.values()
      |> Enum.filter(&(&1 == repeat_count))
      |> Enum.count()

    if count >= 1,
      do: 1,
      else: 0
  end

  defp read_input(filename) do
    File.read!(filename)
    |> String.split("\n")
  end
end
