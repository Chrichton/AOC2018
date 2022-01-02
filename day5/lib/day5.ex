defmodule Day5 do
  def solve1(filename) do
    filename
    |> read_input()
    |> cancel_out()
    |> String.length()
  end

  def cancel_out?(char1, char2) do
    char1 != char2 && String.downcase(char1) == String.downcase(char2)
  end

  def cancel_out(polymer_string) do
    polymer_string
    |> String.codepoints()
    |> Enum.reduce([], fn char, acc ->
      next_acc_cancel_out(char, acc)
    end)
    |> Enum.reverse()
    |> Enum.join()
  end

  defp next_acc_cancel_out(char, []), do: [char]

  defp next_acc_cancel_out(char, [last_char | rest] = acc) do
    if cancel_out?(char, last_char),
      do: rest,
      else: [char | acc]
  end

  def solve2(filename) do
    filename
    |> read_input()
    |> cancel_out_pairs_list()
    |> Enum.map(&String.length/1)
    |> Enum.min()
  end

  def cancel_out_pairs do
    for(
      x <- ?A..?Z,
      do: <<x::utf8>>
    )
    |> Enum.map(&{&1, String.downcase(&1)})
  end

  def cancel_out_pair(polymer_string, {char1, char2}) do
    polymer_string
    |> String.codepoints()
    |> Enum.reduce([], fn char, acc ->
      if char == char1 or char == char2,
        do: acc,
        else: [char | acc]
    end)
    |> Enum.reverse()
    |> Enum.join()
    |> cancel_out()
  end

  def cancel_out_pairs_list(polymer_string) do
    cancel_out_pairs()
    |> Enum.map(fn {_char1, _char2} = pair ->
      cancel_out_pair(polymer_string, pair)
    end)
    |> Enum.uniq()
  end

  def read_input(filename) do
    File.read!(filename)
  end
end
