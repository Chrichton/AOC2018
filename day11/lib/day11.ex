defmodule Day11 do
  @grid_size 300
  @range 1..@grid_size

  def solve1(grid_serial_number) do
    grid_serial_number
    |> calc_power_level_map()
    |> calc_windows(3)
    |> Enum.max_by(fn {_position, power_level, _window_size} -> power_level end)
    |> elem(0)
  end

  def calc_power_level_map(grid_serial_number) do
    for x <- @range, y <- @range, reduce: Map.new() do
      acc -> Map.put(acc, {x, y}, calc_power_level({x, y}, grid_serial_number))
    end
  end

  def calc_windows(power_level_map, window_size) do
    IO.puts("window_size #{window_size}--------------------")
    ranges = Enum.chunk_every(@range, window_size, 1, :discard)

    for x_range <- ranges,
        y_range <- ranges do
      for x <- x_range, y <- y_range, reduce: {nil, 0, window_size} do
        {position, sum, window_size} ->
          power_level = Map.get(power_level_map, {x, y})

          if position == nil,
            do: {{x, y}, sum + power_level, window_size},
            else: {position, sum + power_level, window_size}
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

  # ----------------------------------------------------------------

  def solve2(grid_serial_number) do
    grid_serial_number
    |> calc_power_level_map()
    |> calc_windows_squared()
    |> Enum.max_by(fn {_position, power_level, _window_size} -> power_level end)
    |> then(fn {position, _power_level, window_size} ->
      {position, window_size}
    end)
  end

  def calc_windows_squared(grid_serial_number) do
    max = round(:math.sqrt(@grid_size))

    1..max
    |> Enum.map(&(&1 * &1))
    |> Enum.flat_map(&calc_windows(grid_serial_number, &1))
  end
end
