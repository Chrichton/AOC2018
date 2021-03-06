defmodule Day8 do
  import NimbleParsec

  def solve1(filename) do
    filename
    |> read_input()
    |> to_graph()
    |> Graph.edges()
    |> Enum.flat_map(fn %Graph.Edge{label: metadata} -> metadata end)
    |> Enum.sum()
  end

  def read_input(filename) do
    File.read!(filename)
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
  end

  def to_graph(numbers) do
    get_children(Graph.new(), numbers, nil, ?A, Stream.iterate(?B, &(&1 + 1)))
    |> elem(0)
  end

  def get_children(graph, numbers, parent_id, id, ids_stream) do
    {child_node_count, metadata_count, numbers} =
      numbers
      |> parse_node()

    node_ids = Enum.take(ids_stream, child_node_count)
    ids_stream = drop_ids_stream(ids_stream, child_node_count)

    {graph, numbers, ids_stream} =
      node_ids
      |> Enum.reduce({graph, numbers, ids_stream}, fn node_id, {graph, numbers, ids_stream} ->
        get_children(graph, numbers, id, node_id, ids_stream)
      end)

    metadata =
      numbers
      |> Enum.take(metadata_count)

    numbers =
      numbers
      |> Enum.drop(metadata_count)

    graph = Graph.add_edge(graph, parent_id, id, label: metadata)

    {graph, numbers, ids_stream}
  end

  def parse_node(numbers) do
    {Enum.at(numbers, 0), Enum.at(numbers, 1), Enum.drop(numbers, 2)}
  end

  def drop_ids_stream(ids_stream, 0), do: ids_stream

  def drop_ids_stream(ids_stream, count) do
    Enum.take(ids_stream, count)
    |> List.last()
    |> then(fn last -> Stream.iterate(last + 1, &(&1 + 1)) end)
  end

  def parse_header(string) do
    {:ok, [child_node_count, metadata_count], _, _, _, _} = parsec_header(string)

    {child_node_count, metadata_count}
  end

  # second star ---------------

  def solve2(filename) do
    filename
    |> read_input()
    |> to_graph()
    |> calc_value()
  end

  def calc_value(graph) do
    graph
    |> find_root()
    |> then(fn %Graph.Edge{v2: vertex} = root ->
      calc_value(graph, root, Graph.out_edges(graph, vertex))
    end)
  end

  def calc_value(_graph, %Graph.Edge{label: metadata}, _out_edges = []),
    do: Enum.sum(metadata)

  def calc_value(graph, %Graph.Edge{label: metadata}, out_edges) do
    children_count = Enum.count(out_edges)

    metadata
    |> Enum.reject(&(&1 == 0))
    |> Enum.reduce(0, fn child_index, acc ->
      if child_index > children_count do
        acc
      else
        %Graph.Edge{v2: vertex} = edge = Enum.at(out_edges, child_index - 1)
        acc + calc_value(graph, edge, Graph.out_edges(graph, vertex))
      end
    end)
  end

  def find_root(graph) do
    graph
    |> Graph.edges()
    |> Enum.find(&match?(%Graph.Edge{v1: nil}, &1))
  end

  # Parsing ----------------------------------------------------------------

  defparsecp(
    :parsec_header,
    integer(min: 1)
    |> ignore(string(" "))
    |> integer(min: 1)
    |> ignore(string(" "))
  )
end
