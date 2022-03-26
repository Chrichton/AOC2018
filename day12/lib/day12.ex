defmodule Day12 do
  def solve1(filename) do
    filename
    |> read_input()
  end

  def read_input(filename) do
    File.read!(filename)
    |> String.split("\n", trim: true)
    |> parse_input()
  end

  def parse_input([initial_state | rules]) do
    pots =
      initial_state
      |> String.codepoints()
      |> Enum.with_index()
      |> Enum.filter(fn {element, _index} -> element == "#" end)
      |> MapSet.new(fn {_element, index} -> index end)
  end
end
