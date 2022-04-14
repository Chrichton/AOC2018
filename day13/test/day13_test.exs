defmodule Day13Test do
  use ExUnit.Case

  test "read_input" do
    {cart_map, track_map} = Day13.read_input("sample")

    assert cart_map |> Map.keys() |> Enum.count() == 2

    cart = Map.get(cart_map, {2, 0})
    assert cart.direction == :east
    assert cart.next_turn == :left

    cart = Map.get(cart_map, {9, 3})
    assert cart.direction == :south
    assert cart.next_turn == :left

    track = Map.get(track_map, {0, 0})
    assert track.type == :slash

    track = Map.get(track_map, {2, 0})
    assert track.type == :horitontal

    track = Map.get(track_map, {9, 3})
    assert track.type == :vertical
  end

  test "sort positions" do
    positions = [{1, 2}, {2, 1}, {1, 1}, {1, 2}]

    actual = Enum.sort_by(positions, & &1, Position)

    assert actual == [{1, 1}, {2, 1}, {1, 2}, {1, 2}]
  end

  test "solve1" do
  end

  test "solve2" do
  end
end
