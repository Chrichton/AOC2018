defmodule Day1 do
  def solve1(filename) do
    filename
    |> read_frequency_changes()
    |> Enum.sum()
  end

  def solve2(filename) do
    filename
    |> read_frequency_changes()
    |> find_first_duplicate()
  end

  defp find_first_duplicate(read_frequency_changes) do
    read_frequency_changes
    |> Stream.cycle()
    |> Enum.reduce_while([0], fn curr, acc -> check_duplicate(curr, acc) end)
  end

  defp check_duplicate(curr, acc) do
    new_frequency = curr + List.first(acc)

    if new_frequency in acc do
      {:halt, curr + List.first(acc)}
    else
      {:cont, [new_frequency | acc]}
    end
  end

  defp read_frequency_changes(filename) do
    File.read!(filename)
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
  end
end
