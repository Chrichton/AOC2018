defmodule Day4 do
  def solve1(filename) do
    filename
    |> read_input()
    |> id_with_longest_sleep_time()
    |> then(fn {guard_id, ranges} ->
      longest_minute = longest_minute(ranges)
      guard_id * longest_minute
    end)
  end

  def id_with_longest_sleep_time(%{} = ids_to_ranges) do
    ids_to_ranges
    |> Enum.max_by(fn {_guard_id, ranges} ->
      ranges
      |> Enum.map(&Enum.count(&1))
      |> Enum.sum()
    end)
  end

  def longest_minute(ranges) do
    ranges
    |> Enum.reduce(Map.new(), fn range, acc ->
      range
      |> Enum.reduce(acc, fn minute, map ->
        Map.update(map, minute, 1, fn current_value -> current_value + 1 end)
      end)
    end)
    |> Enum.max_by(fn {_guard_id, count} -> count end)
    |> elem(0)
  end

  def solve2(filename) do
    filename
    |> read_input()
    |> Enum.map(fn {guard_id, ranges} ->
      {guard_id, max_id_and_count(ranges)}
    end)
    |> Enum.max_by(fn {_guard, {_minute, count}} -> count end)
    |> then(fn {guard_id, {minute, _count}} -> guard_id * minute end)
  end

  def max_id_and_count(ranges) do
    ranges
    |> Enum.reduce(Map.new(), fn range, acc ->
      range
      |> Enum.reduce(acc, fn minute, map ->
        Map.update(map, minute, 1, fn current_value -> current_value + 1 end)
      end)
    end)
    |> Enum.max_by(fn {_guard_id, count} -> count end)
  end

  def read_input(filename) do
    File.read!(filename)
    |> String.split("\n", trim: true)
    |> Enum.sort()
    |> Enum.reduce({Map.new(), -1, nil}, fn line, {map, guard_id, asleep_start} ->
      cond do
        String.contains?(line, "Guard #") ->
          guard_id = parse_guard_line(line)

          {map, guard_id, nil}

        String.contains?(line, "falls asleep") ->
          asleep_start = parse_minutes(line)

          {map, guard_id, asleep_start}

        String.contains?(line, "wakes up") ->
          wake_up_time = parse_minutes(line)
          minutes = Range.new(asleep_start, wake_up_time - 1)

          new_map =
            Map.update(map, guard_id, [minutes], fn minutes_list ->
              [minutes | minutes_list]
            end)

          {new_map, guard_id, nil}
      end
    end)
    |> elem(0)
  end

  def parse_guard_line(line) do
    line
    |> String.split("#")
    |> Enum.at(1)
    |> String.split(" ", trim: true)
    |> Enum.at(0)
    |> String.to_integer()
  end

  def parse_minutes(line) do
    line
    |> String.split("]", trim: true)
    |> Enum.at(0)
    |> then(fn line ->
      line
      |> String.slice(String.length(line) - 2, 2)
      |> String.to_integer()
    end)
  end

  def calculate_minutes(asleep_time, wake_up_time) do
    wake_up_time
    |> NaiveDateTime.diff(asleep_time)
    |> div(60)
  end
end
