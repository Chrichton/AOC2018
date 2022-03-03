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
    marble_no_player_no_pairs(last_marble_worth, no_of_playsers)
    |> Enum.reduce({[0], 0, %{}}, fn {marble_no, player_no},
                                     {marbles, current_marble_index, players} ->
      if rem(marble_no, 23) == 0 do
        process_multiples_of_23(marble_no, player_no, marbles, current_marble_index, players)
      else
        process_normal(marble_no, player_no, marbles, current_marble_index, players)
      end
    end)
  end

  def process_multiples_of_23(_marble_no, _player_no, _marbles, _current_marble_index, _players) do
  end

  def process_normal(marble_no, _player_no, marbles, current_marble_index, _players) do
    {_marbles, _current_marble_index} = place_marble(marbles, marble_no, current_marble_index)
  end

  def place_marble(marbles, marble, current_marble_index) do
    first_marble_index =
      Stream.cycle(marbles)
      |> Stream.drop(current_marble_index + 1)
      |> Enum.at(0)
      |> then(fn right_marble -> Enum.find_index(marbles, &(&1 == right_marble)) end)

    insert_index = first_marble_index + 1
    marbles = List.insert_at(marbles, insert_index, marble)

    {marbles, insert_index}
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
