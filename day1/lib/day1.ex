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
    |> Enum.reduce_while({0, MapSet.new()}, fn curr, acc ->
      check_duplicate(curr, acc)
    end)
  end

  defp check_duplicate(curr, {current_frequency, frequencies}) do
    new_frequency = curr + current_frequency

    if new_frequency in frequencies do
      {:halt, new_frequency}
    else
      {:cont, {new_frequency, MapSet.put(frequencies, new_frequency)}}
    end
  end

  defp read_frequency_changes(filename) do
    File.read!(filename)
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
  end
end
