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

    assert actual == expected
  end

  test "to_graph" do
    actual =
      Day7.read_input("sample")
      |> Day7.to_graph()

    assert Graph.to_edgelist(actual) == {:ok, "66 69\n65 66\n65 68\n67 65\n67 70\n68 69\n70 69\n"}

    assert Graph.is_acyclic?(actual)
    refute Graph.is_tree?(actual)
  end

  test "find_roots" do
    graph =
      Day7.read_input("sample")
      |> Day7.to_graph()

    assert Day7.find_roots(graph) == [?C]
  end

  test "reachable_neighbors" do
    graph =
      Day7.read_input("sample")
      |> Day7.to_graph()

    # inputs_and_outputs = [
    #   {{?C, [?C]}, 'AF'},
    #   {{?B, [?B]}, ''},
    #   {{?B, [?B, ?D, ?F]}, 'E'}
    # ]

    # for {{vertex, visited_vertices}, expected_output} <- inputs_and_outputs do
    #   actual = Day7.reachable_neighbors(graph, vertex, visited_vertices)
    #   assert actual == expected_output
    # end

    assert Day7.reachable_neighbors(graph, ?C, [?C]) == 'AF'
    assert Day7.reachable_neighbors(graph, ?B, [?B]) == ''
    assert Day7.reachable_neighbors(graph, ?B, [?B, ?D, ?F]) == 'E'
  end

  test "sample1" do
    assert Day7.solve1("sample") == 'CABDFE'
  end

  test "star1" do
    assert Day7.solve1("star") == 'BKCJMSDVGHQRXFYZOAULPIEWTN'
  end

  test "charlist_duration" do
    assert Day7.charlist_duration('A', 60) == 1 + 60
    assert Day7.charlist_duration('ABCDEF', 60) == 21 + 6 * 60
  end

  test "sample2" do
    assert Day7.solve2("sample", 2, 0) == 15
    # assert Day7.solve2("sample") == 'CABFDE'
  end

  test "star2" do
    assert Day7.solve2("star", 5, 60) == 1040
  end
end
