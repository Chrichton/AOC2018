defmodule Day7 do
  import NimbleParsec

  def solve1(filename) do
    filename
    |> read_input()
    |> to_graph()
    |> Graph.Reducers.Bfs.reduce([], fn v, acc -> {:next, [v | acc]} end)
    |> Enum.reverse()
  end

  def read_input(filename) do
    File.read!(filename)
    |> String.split("\n")
    |> Enum.map(&parse_input/1)
  end

  def parse_input(string) do
    {:ok, [from_step, to_step], "", _, _, _} = parsec_input(string)

    {from_step, to_step}
  end

  def solve2(filename) do
    filename
    |> read_input()
  end

  def to_graph(edges_list) do
    edges_list
    |> Enum.reduce(Graph.new(), fn {from_node, to_node}, graph ->
      Graph.add_edge(graph, from_node, to_node, weight: from_node)
    end)
  end

  def find_root(graph) do
    graph
    |> Graph.vertices()
    |> Enum.find(&(Graph.reaching_neighbors(graph, [&1]) == []))
  end

  # Parsing ----------------------------------------------------------------

  defparsecp(
    :parsec_input,
    ignore(string("Step "))
    |> ascii_char([?A..?Z])
    |> ignore(string(" must be finished before step "))
    |> ascii_char([?A..?Z])
    |> ignore(string(" can begin."))
  )
end
