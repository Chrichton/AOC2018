defmodule Day13Test do
  use ExUnit.Case

  test "read_input" do
    {cart_map, track_map} = Day13.read_input("sample")

    cart = Map.get(cart_map, {2, 0})

    assert cart.direction == :east
    assert cart.next_turn == :left

    cart = Map.get(cart_map, {9, 3})
    assert cart.direction == :south
    assert cart.next_turn == :left
  end

  test "solve1" do
  end

  test "solve2" do
  end
end
