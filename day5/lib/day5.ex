defmodule Day5 do
  def solve1(filename) do
    filename
    |> read_input()
    |> cancel_out()
  end

  def cancel_out?(char1, char2) do
    char1 != char2 && String.downcase(char1) == String.downcase(char2)
  end

  def cancel_out(polymer_string) do
    polymer_string
    |> String.codepoints()
    |> Enum.reduce([], fn char, acc ->
      next_acc(char, acc)
    end)
    |> Enum.count()
  end

  def next_acc(char, []), do: [char]

  def next_acc(char, [last_char | rest] = acc) do
    if cancel_out?(char, last_char),
      do: rest,
      else: [char | acc]
  end

  def solve2(filename) do
    filename
    |> read_input()
  end

  def read_input(filename) do
    File.read!(filename)
  end
end
