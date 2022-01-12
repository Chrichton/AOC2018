defmodule Day7 do
  import NimbleParsec

  def solve1(filename) do
    filename
    |> read_input()
  end

  def parse_input(string) do
    {:ok, [from_step, to_step], "", _, _, _} = parsec_input(string)

    {from_step, to_step}
  end

  def solve2(filename) do
    filename
    |> read_input()
  end

  def read_input(filename) do
    File.read!(filename)
    |> String.split("\n")
    |> Enum.map(&parse_input/1)
  end

  # Parsing ----------------------------------------------------------------

  defparsecp(
    :parsec_input,
    ignore(string("Step "))
    |> ascii_string([?A..?Z], 1)
    |> ignore(string(" must be finished before step "))
    |> ascii_string([?A..?Z], 1)
    |> ignore(string(" can begin."))
  )
end
