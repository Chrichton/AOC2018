defmodule Day14 do
  def solve1() do
  end

  def next_step(recipies, index1, index2) do
    recipies = new_recipies(recipies, index1, index2)
    index1 = calc_index(recipies, index1)
    index2 = calc_index(recipies, index2)

    {recipies, index1, index2}
  end

  def calc_index(recipies, index) do
    rem(Enum.at(recipies, index) + 1, Enum.count(recipies) + 1)
  end

  def new_recipies(recipies, index1, index2) do
    recipies_to_add =
      recipies
      |> score(index1, index2)
      |> Integer.digits()
      |> Enum.take(2)
      |> Enum.reject(&(&1 == nil))

    recipies ++ recipies_to_add
  end

  def score(recipies, index1, index2) do
    Enum.at(recipies, index1) + Enum.at(recipies, index2)
  end

  def solve2() do
  end
end
