defmodule Day1Valim do
  def solve1(filename) do
    filename
    |> read_frequency_changes()
    |> Enum.sum()
  end

  def solve2(filename) do
    filename
    |> read_frequency_changes()
    |> repeated_frequency()
  end

  defp repeated_frequency(file_stream) do
    file_stream
    |> Stream.cycle()
    |> Enum.reduce_while({0, MapSet.new([0])}, fn x, {current_frequency, seen_frequencies} ->
      new_frequency = current_frequency + x

      if new_frequency in seen_frequencies do
        {:halt, new_frequency}
      else
        {:cont, {new_frequency, MapSet.put(seen_frequencies, new_frequency)}}
      end
    end)
  end

  defp read_frequency_changes(filename) do
    File.stream!(filename)
    |> Stream.map(fn line ->
      {integer, _leftover} = Integer.parse(line)
      integer
    end)
  end
end
