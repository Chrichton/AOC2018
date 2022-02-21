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

  def to_graph(edges_list) do
    edges_list
    |> Enum.reduce(Graph.new(), fn {from_node, to_node}, graph ->
      Graph.add_edge(graph, from_node, to_node, weight: from_node)
    end)
  end

  def find_roots(graph) do
    graph
    |> Graph.vertices()
    |> Enum.filter(&(Graph.in_neighbors(graph, &1) == []))
  end

  def reachable_neighbors(graph, vertex, visited_vertices) do
    graph
    |> Graph.out_neighbors(vertex)
    |> Enum.filter(fn out_neighbor ->
      Graph.in_neighbors(graph, out_neighbor)
      |> Enum.all?(&(&1 in visited_vertices))
    end)
  end

  def get_ordered_vertices(graph) do
    graph
    |> find_roots()
    |> Enum.sort()
    |> then(fn roots -> get_ordered_vertices_recusive(graph, roots, []) end)
  end

  def get_ordered_vertices_recusive(_graph, [], visited_vertices),
    do: visited_vertices

  def get_ordered_vertices_recusive(graph, [vertex | next_vertices], visited_vertices) do
    reachable_neighbors = reachable_neighbors(graph, vertex, visited_vertices ++ [vertex])

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

  # second star ---------------

  def solve2(filename) do
    filename
    |> read_input()
    |> to_graph()
    |> seconds()
  end

  def seconds(graph) do
    max_worker_count = 2
    worker_pool = WorkerPool.new(max_worker_count)

    graph
    |> find_roots()
    |> Enum.sort()
    |> then(fn roots -> get_build_time_recusive(graph, roots, [], worker_pool, 0) end)
  end

  def get_build_time_recusive(
        _graph,
        [],
        _visited_vertices,
        %WorkerPool{workers: []},
        seconds
      ),
      do: seconds - 1

  def get_build_time_recusive(
        graph,
        remaining_vertices,
        visited_vertices,
        %WorkerPool{} = worker_pool,
        seconds
      ) do
    {processed_vertices, worker_pool} = WorkerPool.next_step(worker_pool)

    visited_vertices = visited_vertices ++ processed_vertices

    reachable_vertices =
      processed_vertices
      |> Enum.flat_map(fn vertex ->
        reachable_neighbors(graph, vertex, visited_vertices)
      end)

    remaining_vertices =
      remaining_vertices
      |> Enum.concat(reachable_vertices)
      |> Enum.uniq()
      |> Enum.sort()

    available_workers = WorkerPool.available_workers(worker_pool)

    worker_pool =
      remaining_vertices
      |> Enum.take(available_workers)
      |> Enum.reduce(worker_pool, fn char, worker_pool ->
        WorkerPool.add_worker(
          worker_pool,
          WorkerPool.Worker.new(char, seconds_to_complete(char))
        )
      end)

    remaining_vertices =
      remaining_vertices
      |> Enum.drop(available_workers)

    get_build_time_recusive(
      graph,
      remaining_vertices,
      visited_vertices,
      worker_pool,
      seconds + 1
    )
  end

  def charlist_duration(charlist) when is_list(charlist) do
    charlist
    |> Enum.reduce(0, fn char, acc -> acc + seconds_to_complete(char) end)
  end

  def seconds_to_complete(char) do
    base_time = 0

    char + base_time + 1 - ?A
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
