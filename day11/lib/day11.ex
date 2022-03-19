defmodule Day11 do
  @range 1..4

  def solve1(grid_serial_number) do
    grid_serial_number
    |> calc_power_level_map()
    |> calc_windows()
  end

  def calc_power_level_map(grid_serial_number) do
    for x <- @range, y <- @range, reduce: Map.new() do
      acc -> Map.put(acc, {x, y}, calc_power_level({x, y}, grid_serial_number))
    end
  end

  def calc_windows(power_level_map) do
    ranges = Enum.chunk_every(@range, 3, 1, :discard)

    for x_range <- ranges,
        y_range <- ranges do
      for x <- x_range, y <- y_range, reduce: Map.new() do
        acc ->
          power_level = Map.get(power_level_map, {x, y})

          Map.update(acc, {x, y}, power_level, fn old_value ->
            old_value + power_level
          end)
      end
    end
  end

  def calc_power_level({x, y} = _cell_coordinate, grid_serial_number) do
    rack_id = x + 10
    power_level = rack_id * y
    power_level = power_level + grid_serial_number
    power_level = power_level * rack_id
    power_level = extract_hundreds_digit(power_level)
    power_level - 5
  end

  @spec extract_hundreds_digit(integer) :: integer
  def extract_hundreds_digit(number) do
    digits =
      number
      |> Integer.digits()
      |> Enum.reverse()

    if Enum.count(digits) < 3,
      do: 0,
      else: Enum.at(digits, 2)
  end
end
