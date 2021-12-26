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
    |> String.split("\n", trim: true)
  end
end
