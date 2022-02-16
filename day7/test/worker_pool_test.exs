defmodule WorkerPoolTest do
  use ExUnit.Case

  alias WorkerPool.Worker

  test "new" do
    actual = WorkerPool.new(5)

    assert actual.max_worker_count == 5
    assert actual.workers == []
  end

  test "add_worker" do
    actual =
      WorkerPool.new(5)
      |> WorkerPool.add_worker(Worker.new(?A, 60))

    [worker] = actual.workers

    assert worker.char == ?A
    assert worker.seconds_to_complete == 60
  end

  test "available_workers" do
    worker_pool =
      WorkerPool.new(5)
      |> WorkerPool.add_worker(Worker.new(?A, 60))

    assert WorkerPool.available_workers(worker_pool) == 4
  end

  test "next_step" do
    worker_pool =
      WorkerPool.new(5)
      |> WorkerPool.add_worker(Worker.new(?B, 2))
      |> WorkerPool.add_worker(Worker.new(?A, 1))

    {[char], actual} = WorkerPool.next_step(worker_pool)

    assert char == ?A
    assert actual.max_worker_count == 5
    assert actual.workers == [%Worker{char: ?B, seconds_to_complete: 1}]

    assert WorkerPool.available_workers(actual) == 4
  end
end
