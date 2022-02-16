defmodule WorkerPool do
  defmodule Worker do
    alias __MODULE__, as: Worker

    @type t :: %__MODULE__{char: integer, seconds_to_complete: integer}
    @enforce_keys [:char, :seconds_to_complete]
    defstruct [:char, :seconds_to_complete]

    def new(char, seconds) do
      %Worker{char: char, seconds_to_complete: seconds}
    end
  end

  @type t :: %__MODULE__{max_worker_count: integer, workers: [Worker.t()]}
  @enforce_keys [:max_worker_count]
  defstruct [:max_worker_count, workers: []]

  def new(max_worker_count) do
    %WorkerPool{max_worker_count: max_worker_count}
  end

  def add_worker(
        %WorkerPool{workers: workers} = worker_pool,
        %Worker{} = worker
      ) do
    %{worker_pool | workers: [worker | workers]}
  end

  def available_workers(%WorkerPool{
        max_worker_count: max_worker_count,
        workers: workers
      }),
      do: max_worker_count - Enum.count(workers)

  def next_step(%WorkerPool{workers: workers}) do
  end
end
