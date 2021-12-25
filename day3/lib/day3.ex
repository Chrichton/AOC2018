defmodule Day3 do
  def solve1(filename) do
    filename
    |> read_input()
  end

  def solve2(filename) do
    filename
    |> read_input()
  end

  defp read_input(filename) do
    File.read!(filename)
    |> String.split("\n")
  end
end
