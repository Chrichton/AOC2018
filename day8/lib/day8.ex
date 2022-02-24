defmodule Day8 do
  import NimbleParsec

  def solve1(filename) do
    filename
    |> read_input()
    |> to_graph()
  end

  def read_input(filename) do
    File.read!(filename)
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
  end

  def to_graph(numbers) do
    get_children(Graph.new(), numbers, nil, ?A, Stream.iterate(?B, &(&1 + 1)))
  end

  def get_children(graph, numbers, parent_id, id, ids_stream) do
    {child_node_count, metadata_count, remaining_numbers} =
      numbers
      |> parse_node()

    Enum.take(ids_stream, child_node_count)
    |> Enum.reduce(graph, fn node_id, acc ->
      get_children(acc, numbers, parent_id, node_id, ids_stream)
    end)

    _metadata =
      remaining_numbers
      |> Enum.take(metadata_count)

    remaining_numbers =
      remaining_numbers
      |> Enum.drop(metadata_count)

    graph = Graph.add_edge(graph, parent_id, id)

    {graph, remaining_numbers, ids_stream}
  end

  def parse_node(numbers) do
    {Enum.at(numbers, 0), Enum.at(numbers, 1), Enum.drop(numbers, 2)}
  end

  def parse_header(string) do
    {:ok, [child_node_count, metadata_count], _, _, _, _} = parsec_header(string)

    {child_node_count, metadata_count}
  end

  # second star ---------------

  def solve2(filename) do
    filename
    |> read_input()
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
