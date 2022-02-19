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
    |> build_time()
  end

  def build_time(graph) do
    max_worker_count = 5
    worker_pool = WorkerPool.new(max_worker_count)

    graph
    |> find_roots()
    |> Enum.sort()
    |> then(fn roots -> get_build_time_recusive(graph, roots, [], worker_pool, 0) end)
  end

  def get_build_time_recusive(
        graph,
        remaining_vertices,
        visited_vertices,
        %WorkerPool{max_worker_count: worker_count} = worker_pool,
        build_time
      ) do
    if(
      Enum.count(remaining_vertices) == 1 and
        Graph.out_neighbors(graph, hd(remaining_vertices)) |> Enum.count() == 0
    ) do
      build_time + charlist_duration(remaining_vertices)
    else
      {processed_vertices, step_worker_pool} = WorkerPool.next_step(worker_pool)

      available_vertices = processed_vertices ++ remaining_vertices

      reachable_vertices =
        available_vertices
        |> Enum.reject(fn vertex ->
          reachable_neighbors(graph, vertex, visited_vertices ++ available_vertices) == []
        end)

      new_remaining_vertices =
        remaining_vertices
        |> Enum.concat(reachable_vertices)
        |> Enum.uniq()
        |> Enum.sort()

      new_worker_pool =
        new_remaining_vertices
        |> Enum.take(worker_count)
        |> Enum.reduce(step_worker_pool, fn char, worker_pool ->
          WorkerPool.add_worker(
            worker_pool,
            WorkerPool.Worker.new(char, seconds_to_complete(char))
          )
        end)

      next_vertices =
        new_remaining_vertices
        |> Enum.drop(worker_count)

      IO.inspect(next_vertices)
      IO.inspect(visited_vertices)
      IO.inspect(new_remaining_vertices)
      IO.inspect(processed_vertices)
      IO.inspect(reachable_vertices)
      IO.inspect(new_worker_pool, label: "\n")

      if build_time < 3 do
        get_build_time_recusive(
          graph,
          next_vertices,
          visited_vertices ++ processed_vertices,
          new_worker_pool,
          build_time + charlist_duration(processed_vertices)
        )
      end
    end
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
