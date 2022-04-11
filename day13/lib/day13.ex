defmodule Track do
end

defmodule Cart do
  @type direction :: :north | :east | :south | :west
  @enforce_keys [:direction]

  defstruct [:direction, next_direction: :east]

  @type t :: %__MODULE__{direction: direction(), next_direction: direction()}

  def new(direction), do: %Cart{direction: direction}

  def next_direction(%Cart{next_direction: next_direction}) do
    direction = next_direction

    next_direction =
      case next_direction do
        :north -> :east
        :east -> :south
        :south -> :west
        :west -> :north
      end

    %Cart{direction: direction, next_direction: next_direction}
  end
end

defmodule Day13 do
  def read_input(filename) do
    File.read!(filename)
    |> String.split("\n", trim: true)
  end

  def solve1(filename) do
    filename
    |> read_input()
  end

  def solve2(filename) do
    filename
    |> read_input()
  end
end
