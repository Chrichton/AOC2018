defmodule Day11 do
  def solve1(grid_serial_number) do
  end

  def calc_power_level({x, y} = _cell_coordinate, grid_serial_number) do
    rack_id = x + 10
    power_level = rack_id * y
    power_level = power_level + grid_serial_number
    power_level = power_level * rack_id
    hundreds_digit = extract_hundreds_digit(power_level)
    power_level - hundreds_digit
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
