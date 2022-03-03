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
        place_marble(marble_no, marbles, current_marble_index, players)
      end
    end)
    |> elem(2)
    |> Map.values()
    |> Enum.max()
  end

  def process_multiples_of_23(marble_no, player_no, marbles, current_marble_index, players) do
    {removed_marble_no, marbles, new_marble_index} =
      pop_marble(
        marbles,
        current_marble_index
      )

    score = marble_no + removed_marble_no
    players = Map.update(players, player_no, score, &(&1 + score))

    {marbles, new_marble_index, players}
  end

  def pop_marble(marbles, current_marble_index) do
    remove_index = next_marble_index(marbles, current_marble_index, -7)
    {removed_marble_no, marbles} = List.pop_at(marbles, remove_index)

    new_marble_index =
      if remove_index == Enum.count(marbles),
        do: remove_index - 1,
        else: remove_index

    {removed_marble_no, marbles, new_marble_index}
  end

  def place_marble(marble_no, marbles, current_marble_index, players) do
    insert_index = next_marble_index(marbles, current_marble_index, 1) + 1

    marbles = List.insert_at(marbles, insert_index, marble_no)

    {marbles, insert_index, players}
  end

  def next_marble_index(marbles, current_marble_index, increment) do
    rem(current_marble_index + increment, Enum.count(marbles))
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
