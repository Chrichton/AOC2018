defmodule Day13Test do
  use ExUnit.Case

  test "read_input" do
    {carts, track_map} = Day13.read_input("sample")

    assert Enum.count(carts) == 2

    cart = Enum.at(carts, 0)
    assert cart.direction == :south
    assert cart.next_turn == :left
    assert cart.position == {9, 3}

    cart = Enum.at(carts, 1)
    assert cart.direction == :east
    assert cart.next_turn == :left
    assert cart.position == {2, 0}

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

  test "next_step" do
    {carts, track_map} = Day13.read_input("sample")
    next_carts = Day13.next_step(carts, track_map)

    assert Enum.count(next_carts) == 2

    cart = Enum.at(next_carts, 0)
    assert cart.direction == :east
    assert cart.next_turn == :straight
    assert cart.position == {9, 4}

    cart = Enum.at(next_carts, 1)
    assert cart.direction == :east
    assert cart.next_turn == :left
    assert cart.position == {3, 0}
  end

  test "solve1" do
  end

  test "solve2" do
  end
end