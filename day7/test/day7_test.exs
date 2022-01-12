defmodule Day7Test do
  use ExUnit.Case

  test "read_input" do
    actual = Day7.read_input("sample")

    expected = [
      {67, 65},
      {67, 70},
      {65, 66},
      {65, 68},
      {66, 69},
      {68, 69},
      {70, 69}
    ]
  end

  test "to_graph" do
    from_to_nodes = Day7.read_input("sample")

    actual = Day7.to_graph(from_to_nodes)

    assert Graph.to_edgelist(actual) == {:ok, "66 69\n65 66\n65 68\n67 65\n67 70\n68 69\n70 69\n"}
  end

  test "sample1" do
    assert Day7.solve1("sample") == "CABDFE"
  end

  test "star1" do
    assert Day7.solve1("star") == 3969
  end

  test "sample2" do
    assert Day7.solve2("sample") == 17
  end

  test "star2" do
    assert Day7.solve2("star") == 3969
  end
end
