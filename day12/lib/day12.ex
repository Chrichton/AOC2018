defmodule Day12 do
  defmodule Rule do
    defstruct [:prev_prev, :prev, :current, :next, :next_next, :result]

    def new([prev_prev, prev, current, next, next_next], result) do
      %Rule{
        prev_prev: prev_prev,
        prev: prev,
        current: current,
        next: next,
        next_next: next_next,
        result: result
      }
    end
  end

  def solve1(filename, generations) do
    filename
    |> read_input()
    |> next_generations(generations)
    |> MapSet.to_list()
    |> Enum.sum()
  end

  def next_generations({pots, rules}, generations) do
    generations
    |> Enum.reduce(pots, fn _pass, acc ->
      next_generation(rules, acc)
    end)
  end

  def next_generation(rules, pots) do
    pots
    |> pot_range()
    |> Enum.reduce(MapSet.new(), fn pot, acc ->
      if rules_result(rules, pots, pot),
        do: MapSet.put(acc, pot),
        else: acc
    end)
  end

  def pot_range(pots) do
    pots
    |> MapSet.to_list()
    |> then(fn list -> (Enum.min(list) - 2)..(Enum.max(list) + 2) end)
  end

  def rules_result(rules, pots, pot) do
    rules
    |> Enum.reduce_while(false, fn rule, acc ->
      if check_rule(rule, pots, pot),
        do: {:halt, rule.result},
        else: {:cont, acc}
    end)
  end

  def check_rule(rule, pots, pot) do
    rule.current == MapSet.member?(pots, pot) &&
      rule.prev == MapSet.member?(pots, pot - 1) &&
      rule.prev_prev == MapSet.member?(pots, pot - 2) &&
      rule.next == MapSet.member?(pots, pot + 1) &&
      rule.next_next == MapSet.member?(pots, pot + 2)
  end

  def parse_rule(rule_line) do
    condition_stop_index = index_of(rule_line, "=") - 1

    conditions =
      rule_line
      |> String.slice(0, condition_stop_index)
      |> String.codepoints()
      |> Enum.map(fn
        "." -> false
        "#" -> true
      end)

    result_index = index_of(rule_line, ">") + 2
    result = String.slice(rule_line, result_index, 1) == "#"

    Rule.new(conditions, result)
  end

  def read_input(filename) do
    File.read!(filename)
    |> String.split("\n", trim: true)
    |> parse_input()
  end

  def parse_input([initial_state_line | rule_lines]) do
    start_index = index_of(initial_state_line, ":") + 2

    pots =
      initial_state_line
      |> String.slice(start_index, String.length(initial_state_line))
      |> String.codepoints()
      |> Enum.with_index()
      |> Enum.filter(fn {element, _index} -> element == "#" end)
      |> MapSet.new(fn {_element, index} -> index end)

    rules =
      rule_lines
      |> Enum.map(&parse_rule/1)

    {pots, rules}
  end

  def index_of(string, substring) do
    :binary.match(string, substring)
    |> elem(0)
  end
end
