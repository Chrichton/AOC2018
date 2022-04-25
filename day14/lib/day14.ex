defmodule Day14 do
  def solve1(n) do
    score_after_recipies([3, 7], 0, 1, n)
  end

  def score_after_recipies(recipies, index1, index2, n) do
    {recipies, index1, index2} = next_step(recipies, index1, index2)

    if Enum.count(recipies) >= n + 10 do
      recipies
      |> Enum.reverse()
      |> Enum.take(10)
      |> Enum.reverse()
    else
      score_after_recipies(recipies, index1, index2, n)
    end
  end

  def next_step(recipies, index1, index2) do
    recipies = new_recipies(recipies, index1, index2)
    index1 = calc_index(recipies, index1)
    index2 = calc_index(recipies, index2)

    {recipies, index1, index2}
  end

  def calc_index(recipies, index) do
    rem(index + Enum.at(recipies, index) + 1, Enum.count(recipies))
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
    Enum.at(recipies, index1, 0) + Enum.at(recipies, index2, 0)
  end

  def sublist_index([], _, _), do: -1

  def sublist_index(l1 = [_ | t], l2, i) do
    if List.starts_with?(l1, l2),
      do: i,
      else: sublist_index(t, l2, i + 1)
  end

  def solve2(n, digits) do
    first_appearance_of_digits([3, 7], 0, 1, n, digits)
  end

  def first_appearance_of_digits(recipies, index1, index2, n, digits) do
    {recipies, index1, index2} = next_step(recipies, index1, index2)

    if Enum.count(recipies) >= n + 10 do
      sublist_index(recipies, digits, 0)
    else
      first_appearance_of_digits(recipies, index1, index2, n, digits)
    end
  end
end
