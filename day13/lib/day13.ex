defmodule Track do
  @type type ::
          :horitontal
          | :vertical
          | :slash
          | :backslash
          | :crossing

  @enforce_keys [:type]

  defstruct [:type]

  @type t :: %__MODULE__{type: type()}

  def new(type), do: %Track{type: type}
end

defmodule Cart do
  @type direction :: :north | :east | :south | :west
  @type turn :: :left | :straight | :right
  @enforce_keys [:direction]

  defstruct [:position, :direction, next_turn: :left]

  @type t :: %__MODULE__{
          direction: direction(),
          next_turn: turn(),
          position: {integer, integer}
        }

  def new(direction, position), do: %Cart{direction: direction, position: position}

  def move(%Cart{} = cart, track_map) do
    next_position = next_position(cart.position, cart.direction)
    track_type = Map.get(track_map, next_position).type

    case track_type do
      :crossing -> turn_crossing(cart, next_position)
      :slash -> turn_slash(cart, next_position)
      :backslash -> turn_backslash(cart, next_position)
      _ -> %{cart | position: next_position}
    end
  end

  defp turn_slash(%Cart{direction: direction} = cart, next_position) do
    next_direction =
      case direction do
        :north -> :east
        :west -> :south
        :south -> :west
        :east -> :north
      end

    %{cart | direction: next_direction, position: next_position}
  end

  defp turn_backslash(%Cart{direction: direction} = cart, next_position) do
    next_direction =
      case direction do
        :north -> :west
        :west -> :north
        :south -> :east
        :east -> :south
      end

    %{cart | direction: next_direction, position: next_position}
  end

  defp turn_crossing(%Cart{direction: direction, next_turn: :left} = cart, next_position) do
    next_direction =
      case direction do
        :north -> :west
        :west -> :south
        :south -> :east
        :east -> :north
      end

    %{cart | direction: next_direction, next_turn: :straight, position: next_position}
  end

  defp turn_crossing(%Cart{direction: direction, next_turn: :straight} = cart, next_position) do
    %{cart | direction: direction, next_turn: :right, position: next_position}
  end

  defp turn_crossing(%Cart{direction: direction, next_turn: :right} = cart, next_position) do
    next_direction =
      case direction do
        :north -> :east
        :east -> :south
        :south -> :west
        :west -> :north
      end

    %{cart | direction: next_direction, next_turn: :left, position: next_position}
  end

  defp next_position({x, y}, direction) do
    case direction do
      :north -> {x, y - 1}
      :east -> {x + 1, y}
      :south -> {x, y + 1}
      :west -> {x - 1, y}
    end
  end
end

defmodule Position do
  def compare({_x1, _y1} = pos1, {_x2, _y2} = pos2) when pos1 == pos2,
    do: :eq

  def compare({_x1, y1}, {_x2, y2}) when y1 < y2, do: :lt

  def compare({_x1, y1}, {_x2, y2}) when y1 > y2, do: :gt

  def compare({x1, y1}, {x2, y2}) when y1 == y2 do
    if x1 < x2,
      do: :lt,
      else: :gt
  end
end

defmodule Day13 do
  def read_input(filename) do
    File.read!(filename)
    |> String.split("\n")
    |> Enum.with_index(fn lines, y_index ->
      lines
      |> String.codepoints()
      |> Enum.with_index(fn char, x_index ->
        {x_index, y_index, char}
      end)
    end)
    |> Enum.flat_map(fn x -> x end)
    |> Enum.reduce({[], Map.new()}, fn {x, y, char}, {carts, track_map} ->
      case char do
        "-" ->
          {carts, Map.put(track_map, {x, y}, Track.new(:horitontal))}

        "|" ->
          {carts, Map.put(track_map, {x, y}, Track.new(:vertical))}

        "/" ->
          {carts, Map.put(track_map, {x, y}, Track.new(:slash))}

        "\\" ->
          {carts, Map.put(track_map, {x, y}, Track.new(:backslash))}

        "+" ->
          {carts, Map.put(track_map, {x, y}, Track.new(:crossing))}

        "^" ->
          {[Cart.new(:north, {x, y}) | carts], Map.put(track_map, {x, y}, Track.new(:vertical))}

        ">" ->
          {[Cart.new(:east, {x, y}) | carts], Map.put(track_map, {x, y}, Track.new(:horitontal))}

        "v" ->
          {[Cart.new(:south, {x, y}) | carts], Map.put(track_map, {x, y}, Track.new(:vertical))}

        "<" ->
          {[Cart.new(:west, {x, y}) | carts], Map.put(track_map, {x, y}, Track.new(:horitontal))}

        " " ->
          {carts, track_map}
      end
    end)
  end

  def next_step(carts, track_map) do
    carts
    |> Enum.sort_by(fn %Cart{position: position} -> position end, Position)
    |> Enum.reduce([], fn %Cart{} = cart, acc ->
      [Cart.move(cart, track_map) | acc]
    end)
  end

  def solve1(filename) do
    filename
    |> read_input()
    |> find_first_crash()
  end

  def find_first_crash({carts, track_map}) do
    carts = next_step(carts, track_map)

    positions = Enum.map(carts, & &1.position)

    duplicate =
      (positions -- Enum.uniq(positions))
      |> Enum.sort(Position)
      |> Enum.at(0)

    if duplicate != nil,
      do: duplicate,
      else: find_first_crash({carts, track_map})
  end

  def solve2(filename) do
    filename
    |> read_input()
    |> locate_last_cart()
  end

  def locate_last_cart({carts, track_map}) do
    next_carts = next_step_2(carts, track_map)

    if Enum.count(next_carts) == 1,
      do: {carts, Enum.at(next_carts, 0)},
      else: locate_last_cart({next_carts, track_map})
  end

  def next_step_2(carts, track_map) do
    carts
    |> Enum.sort_by(fn %Cart{position: position} -> position end, Position)
    |> Enum.reduce([], fn %Cart{} = cart, acc ->
      next_cart = Cart.move(cart, track_map)

      if index = Enum.find_index(acc, &(&1.position == next_cart.position)),
        do: List.delete_at(acc, index),
        else: [next_cart | acc]
    end)
  end
end
