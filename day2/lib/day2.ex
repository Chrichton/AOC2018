defmodule Day2 do
  def solve1(filename) do
    filename
    |> read_input()
    |> calc_checksum()
  end

  defp calc_checksum(box_ids) do
    threes =
      box_ids
      |> Enum.map(&box_repeat_count(&1, 3))
      |> Enum.sum()

    twos =
      box_ids
      |> Enum.map(&box_repeat_count(&1, 2))
      |> Enum.sum()

    twos * threes
  end

  def box_repeat_count(string, repeat_count) do
    if repeats(string, repeat_count) >= 1,
      do: 1,
      else: 0
  end

  def repeats(string, repeat_count) do
    count =
      string
      |> String.codepoints()
      |> Enum.frequencies()
      |> Map.values()
      |> Enum.filter(&(&1 == repeat_count))
      |> Enum.count()
  end

  defp read_input(filename) do
    File.read!(filename)
    |> String.split("\n")
  end
end
