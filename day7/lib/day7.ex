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
    step_duration = 60

    if(
      Enum.count(remaining_vertices) == 1 and
        Graph.out_neighbors(graph, hd(remaining_vertices)) |> Enum.count() == 0
    ) do
      build_time + step_duration + charlist_duration(remaining_vertices)
    else
      {processed_vertices, step_worker_pool} = WorkerPool.next_step(worker_pool)

      vertices =
        remaining_vertices
        |> Enum.concat(processed_vertices)
        |> Enum.sort()

      reachables =
        vertices
        |> Enum.map(&{&1, reachable_neighbors(graph, &1, visited_vertices ++ vertices)})

      reachable_vertices =
        reachables
        |> Enum.reject(fn {_vertex, reachable_neighbors} ->
          reachable_neighbors == []
        end)
        |> Enum.map(fn {vertex, _reachable} -> vertex end)

      new_worker_pool =
        reachable_vertices
        |> Enum.drop(worker_count)
        |> Enum.reduce(step_worker_pool, fn char, worker_pool ->
          WorkerPool.add_worker(
            worker_pool,
            WorkerPool.Worker.new(char, step_duration)
          )
        end)

      next_vertices =
        reachables
        |> Enum.filter(fn {_vertex, reachable_neighbors} ->
          reachable_neighbors == []
        end)
        |> Enum.map(fn {vertex, _reachable_neighbors} -> vertex end)
        |> Enum.uniq()
        |> Enum.sort()

      get_build_time_recusive(
        graph,
        next_vertices,
        visited_vertices ++ processed_vertices,
        new_worker_pool,
        build_time + step_duration + charlist_duration(processed_vertices)
      )
    end
  end

  def charlist_duration(charlist) when is_list(charlist) do
    charlist
    |> Enum.reduce(0, fn char, acc -> acc + char - ?A + 1 end)
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
