defmodule Day4 do

  def solve1(filename) do
  filename
    |> read_input()
  end

  def solve2(filename) do
    filename
      |> read_input()
    end

  def read_input(filename) do
    File.read!(filename)
    filename
    |> String.split("\n", trim: true)
    |> Enum.reduce({Map.new(), 0, nil}, fn line, {map, guard_id, asleep_time} ->
      cond do

      String.contains?(line, "Guard #") ->
        guard_id = parse_guard_lines(line)
        {map, guard_id}

      String.contains?(line, "falls asleep") ->
       asleep_time = parse_time(line)
       {map, guard_id, asleep_time}

      String.contains?(line, "wakes up") ->
         wake_up_time = parse_time(line)
         diff_time = NaiveDateTime.diff(wake_up_time, asleep_time)
         minutes = nil
         Map.update(map, guard_id, [minutes], fn minutes_list ->
          [minutes | minutes_list] end)
      end
    end)
  end

  def parse_guard_lines(lines) do
   lines
    |> Enum.take(1)
    |> then(fn [guard_id_line] ->
      String.split(guard_id_line, "#")
      |> Enum.at(1)
      |> String.split(" ", trim: true)
      |> Enum.at(0)
      |> String.to_integer()
    end)
  end

  def parse_time(line) do
    line
    |> String.split("]", trim: true)
    |> Enum.at(0)
    |> then(fn line ->
      line
      |> String.slice(1, String.length(line) - 1)
      |> then(fn date_string -> date_string <> ":00"
      end)
      |> NaiveDateTime.from_iso8601!()
    end)
  end
end
