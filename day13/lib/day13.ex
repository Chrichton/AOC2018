defmodule Track do
  @type type ::
          :horitontal
          | :vertical
          | :slash
          | :back_slash
          | :crossing

  @enforce_keys [:type]

  defstruct [:type]

  @type t :: %__MODULE__{type: type()}

  def new(type), do: %Track{type: type}

  def new(track_map, {x, y}, direction) do
    if Map.get(track_map, {x, y}) != nil do
      Track.new(:crossing)
    else
      case direction do
        :west -> Track.new(:horitontal)
        :east -> Track.new(:horitontal)
        :north -> Track.new(:vertical)
        :south -> Track.new(:vertical)
      end
    end
  end
end

defmodule Cart do
  @type direction :: :north | :east | :south | :west
  @type turn :: :left | :straight | :right
  @enforce_keys [:direction]

  defstruct [:direction, next_turn: :left]

  @type t :: %__MODULE__{direction: direction(), next_turn: turn()}

  def new(direction), do: %Cart{direction: direction}

  def turn(%Cart{direction: direction, next_turn: :left}) do
    next_direction =
      case direction do
        :north -> :west
        :west -> :south
        :south -> :east
        :east -> :north
      end

    %Cart{direction: next_direction, next_turn: :straight}
  end

  def turn(%Cart{direction: direction, next_turn: :straight}) do
    %Cart{direction: direction, next_turn: :right}
  end

  def turn(%Cart{direction: direction, next_turn: :right}) do
    next_direction =
      case direction do
        :north -> :east
        :east -> :south
        :south -> :west
        :west -> :north
      end

    %Cart{direction: next_direction, next_turn: :left}
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
    |> Enum.reduce({Map.new(), Map.new()}, fn {x, y, char}, {cart_map, track_map} ->
      case char do
        "-" ->
          {cart_map, Map.put(track_map, {x, y}, Track.new(:horitontal))}

        "|" ->
          {cart_map, Map.put(track_map, {x, y}, Track.new(:vertical))}

        "/" ->
          {cart_map, Map.put(track_map, {x, y}, Track.new(:slash))}

        "\\" ->
          {cart_map, Map.put(track_map, {x, y}, Track.new(:back_slash))}

        "+" ->
          {cart_map, Map.put(track_map, {x, y}, Track.new(:crossing))}

        "^" ->
          {Map.put(cart_map, {x, y}, Cart.new(:east)),
           Map.put(track_map, {x, y}, Track.new(track_map, {x, y}, :north))}

        ">" ->
          {Map.put(cart_map, {x, y}, Cart.new(:east)),
           Map.put(track_map, {x, y}, Track.new(track_map, {x, y}, :east))}

        "v" ->
          {Map.put(cart_map, {x, y}, Cart.new(:south)),
           Map.put(track_map, {x, y}, Track.new(track_map, {x, y}, :south))}

        "<" ->
          {Map.put(cart_map, {x, y}, Cart.new(:east)),
           Map.put(track_map, {x, y}, Track.new(track_map, {x, y}, :west))}

        " " ->
          {cart_map, track_map}
      end
    end)
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
