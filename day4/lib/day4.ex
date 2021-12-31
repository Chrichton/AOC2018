defmodule Day4 do
  def solve1(filename) do
    filename
    |> read_input()
    |> Enum.max_by(fn {_guard_id, minutes_list} ->
      Enum.sum(minutes_list)
    end)
    |> then(fn {guard_id, minutes_list} ->
      max_minutes = Enum.max(minutes_list) - 1
      guard_id * max_minutes
    end)
  end

  def solve2(filename) do
    filename
    |> read_input()
  end

  def read_input(filename) do
    File.read!(filename)
    |> String.split("\n", trim: true)
    |> Enum.sort()
    |> Enum.reduce({Map.new(), -1, nil}, fn line, {map, guard_id, asleep_time} ->
      cond do
        String.contains?(line, "Guard #") ->
          guard_id = parse_guard_line(line)

          {map, guard_id, asleep_time}

        String.contains?(line, "falls asleep") ->
          asleep_time = parse_time(line)

          {map, guard_id, asleep_time}

        String.contains?(line, "wakes up") ->
          wake_up_time = parse_time(line)
          minutes = calculate_minutes(asleep_time, wake_up_time)

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

  def parse_time(line) do
    line
    |> String.split("]", trim: true)
    |> Enum.at(0)
    |> then(fn line ->
      line
      |> String.slice(1, String.length(line) - 1)
      |> then(fn date_string -> date_string <> ":00" end)
      |> NaiveDateTime.from_iso8601!()
    end)
  end

  def calculate_minutes(asleep_time, wake_up_time) do
    wake_up_time
    |> NaiveDateTime.diff(asleep_time)
    |> div(60)
  end
end
