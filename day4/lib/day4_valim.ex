defmodule FrequencyMap do
  defstruct data: %{}

  def new do
    %FrequencyMap{}
  end

  def most_frequent(%FrequencyMap{data: data}) do
    {key, _} = Enum.max_by(data, fn {_key, count} -> count end)

    key
  end

  defimpl Collectable do
    def into(%FrequencyMap{data: data}) do
      collector_fun = fn
        data, {:cont, elem} ->
          Map.update(data, elem, 1, &(&1 + 1))

        data, :done ->
          %FrequencyMap{data: data}

        _, :halt ->
          :ok
      end

      {data, collector_fun}
    end
  end
end

defmodule Day4Valim do
  import NimbleParsec

  def sum_asleep_times_by_id(grouped_entries) do
    Enum.reduce(grouped_entries, %{}, fn {id, _date, ranges}, acc ->
      time_asleep = ranges |> Enum.map(&Enum.count/1) |> Enum.sum()

      Map.update(acc, id, time_asleep, &(&1 + time_asleep))
    end)
  end

  def parse_log(string) when is_binary(string) do
    {:ok, [year, month, day, hour, minute, id], "", _, _, _} = parsec_log(string)

    {{year, month, day}, hour, minute, id}
  end

  def group_by_id_and_date(unsorted_logs_as_strings) do
    unsorted_logs_as_strings
    |> Enum.map(&parse_log/1)
    |> Enum.sort()
    |> group_by_id_and_date([])
  end

  defp group_by_id_and_date([{date, _hour, _minute, :shift, id} | rest], groups) do
    {rest, ranges} = get_asleep_ranges(rest, [])
    group_by_id_and_date(rest, [{id, date, ranges} | groups])
  end

  defp group_by_id_and_date([], groups) do
    Enum.reverse(groups)
  end

  defp get_asleep_ranges(
         [{_, _, down_minute, :down}, {_, _, up_minute, :up} | rest],
         ranges
       ) do
    get_asleep_ranges(rest, [down_minute..(up_minute - 1) | ranges])
  end

  defp get_asleep_ranges(rest, ranges) do
    {rest, Enum.reverse(ranges)}
  end

  def id_asleep_the_most(map) do
    {id, _} = Enum.max_by(map, fn {_id, time_asleep} -> time_asleep end)

    id
  end

  def minute_asleep_the_most_by_id(list, id) do
    frequency_map =
      for {^id, _, ranges} <- list,
          range <- ranges,
          minute <- range,
          do: minute,
          into: FrequencyMap.new()

    FrequencyMap.most_frequent(frequency_map)
  end

  # Parsing ----------------------------------------------------------------

  guard_command =
    ignore(string("Guard #"))
    |> integer(min: 1)
    |> ignore(string(" begins shift"))
    |> unwrap_and_tag(:shift)

  asleep_command =
    string("falls asleep")
    |> replace(:down)

  wake_up_command =
    string("wakes up")
    |> replace(:up)

  defparsecp(
    :parsec_log,
    ignore(string("["))
    |> integer(4)
    |> ignore(string("-"))
    |> integer(2)
    |> ignore(string("-"))
    |> integer(2)
    |> ignore(string(" "))
    |> integer(2)
    |> ignore(string(":"))
    |> integer(2)
    |> ignore(string("] "))
    |> choice([
      guard_command,
      asleep_command,
      wake_up_command
    ])
  )
end
