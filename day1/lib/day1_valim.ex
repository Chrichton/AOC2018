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
    # use Task, so that the Process-Dictionary is not leaking.
    # Otherwise it would be global
    # time HashSet: 0.1 sec
    # time Process: 1,27s user 0,34s system 147% cpu 1,094 total
    # On Valims Machine, this is faster than HashSet (why?)

    Task.async(fn ->
      Process.put({__MODULE__, 0}, true)

      file_stream
      |> Stream.cycle()
      |> Enum.reduce_while(0, fn x, current_frequency ->
        new_frequency = current_frequency + x
        key = {__MODULE__, new_frequency}

        if Process.get(key) do
          {:halt, new_frequency}
        else
          Process.put(key, true)
          {:cont, new_frequency}
        end
      end)
    end)
    |> Task.await(:infinity)
  end

  defp read_frequency_changes(filename) do
    File.stream!(filename)
    |> Stream.map(fn line ->
      {integer, _leftover} = Integer.parse(line)
      integer
    end)
  end
end
