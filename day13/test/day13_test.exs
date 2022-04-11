defmodule Day13Test do
  use ExUnit.Case

  test "read_input" do
    {cart_map, track_map} = Day13.read_input("sample")

    %Cart{direction: direction} = Map.get(cart_map, {2, 0})
    assert direction == :east

    %Cart{direction: direction} = Map.get(cart_map, {9, 3})
    assert direction == :south
  end

  test "solve1" do
  end

  test "solve2" do
  end
end
