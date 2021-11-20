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

  def solve2(filename) do
    filename
    |> read_input()
    |> calc_common_letters()
  end

  defp calc_common_letters([box_id | tail]) do
    common_string = find_common_string(box_id, tail)

    if common_string != nil,
      do: common_string,
      else: calc_common_letters(tail)
  end

  defp find_common_string(_box_id1, []), do: nil

  defp find_common_string(box_id1, [box_id_2 | tail]) do
    differences_string = differences_string(box_id1, box_id_2)

    if String.length(box_id1) == String.length(differences_string) + 1,
      do: differences_string,
      else: find_common_string(box_id1, tail)
  end

  def differences_string(string1, string2) do
    string1
    |> String.codepoints()
    |> Enum.zip(String.codepoints(string2))
    |> Enum.reduce("", fn {char1, char2}, acc ->
      if char1 == char2, do: acc <> char1, else: acc
    end)
  end
end
