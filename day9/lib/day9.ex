defmodule Day9 do
  import NimbleParsec

  def solve1(filename) do
    filename
    |> read_input()
    |> winning_score()
  end

  def read_input(filename) do
    File.read!(filename)
    |> parse_input()
  end

  def winning_score({no_of_playsers, last_marble_worth}) do
  end

  def parse_input(string) do
    {:ok, [no_of_playsers, last_marble_worth], "", _, _, _} = parsec_input(string)

    {no_of_playsers, last_marble_worth}
  end

  def marble_no_player_no_pairs(no_of_marbles, no_of_players) do
    Enum.zip(1..no_of_marbles, Stream.cycle(1..no_of_players))
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
