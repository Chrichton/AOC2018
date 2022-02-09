defmodule Day7 do
  import NimbleParsec

  def solve1(filename) do
    filename
    |> read_input()
    |> to_graph()
    |> get_ordered_vertices()
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
    |> Enum.find(&root?(graph, &1))
  end

  def root?(graph, vertex), do: Graph.in_neighbors(graph, vertex) == []

  def reachable_neighbors(graph, vertex, visited_vertices) do
    visited_vertices = [vertex | visited_vertices]

    graph
    |> Graph.out_neighbors(vertex)
    |> Enum.filter(fn out_neighbor ->
      Graph.in_neighbors(graph, out_neighbor)
      |> Enum.all?(&(&1 in visited_vertices))
    end)
  end

  def get_ordered_vertices(graph) do
    graph
    |> find_root()
    |> then(fn root -> get_ordered_vertices_recusive(graph, [root], []) end)
  end

  def get_ordered_vertices_recusive(_graph, [], visited_vertices),
    do: visited_vertices

  def get_ordered_vertices_recusive(graph, [vertex | next_vertices], visited_vertices) do
    reachable_neighbors = reachable_neighbors(graph, vertex, visited_vertices)

    next_vertices =
      (next_vertices ++ reachable_neighbors)
      |> Enum.uniq()
      |> Enum.sort()

    get_ordered_vertices_recusive(
      graph,
      next_vertices,
      visited_vertices ++ [vertex]
    )
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
