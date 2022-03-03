defmodule Day9 do
  import NimbleParsec

  def solve1(filename) do
    filename
    |> read_input()
  end

  def read_input(filename) do
    File.read!(filename)
    |> String.split("\n")
    |> Enum.map(&parse_input/1)
  end

  def parse_input(string) do
    {:ok, [from_step, to_step], "", _, _, _} = parsec_input(string)

    {from_step, to_step}
  end

  # second star ---------------

  def solve2(filename) do
    filename
    |> read_input()
  end

  # Parsing ----------------------------------------------------------------

  defparsecp(
    :parsec_input,
    integer(min: 1)
    |> ignore(string(" players; last marble is worth "))
    |> integer(min: 1)
    |> ignore(string(" points"))
  )
end
