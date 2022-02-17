defmodule WorkerPool do
  defmodule Worker do
    alias __MODULE__, as: Worker

    @type t :: %__MODULE__{char: non_neg_integer(), seconds_to_complete: pos_integer()}
    @enforce_keys [:char, :seconds_to_complete]
    defstruct [:char, :seconds_to_complete]

    @spec new(non_neg_integer(), pos_integer()) :: WorkerPool.Worker.t()
    def new(char, seconds) when is_integer(char) and is_integer(seconds) do
      %Worker{char: char, seconds_to_complete: seconds}
    end
  end

  @type t :: %__MODULE__{max_worker_count: pos_integer(), workers: [Worker.t()]}
  @enforce_keys [:max_worker_count]
  defstruct [:max_worker_count, workers: []]

  @spec new(pos_integer()) :: WorkerPool.t()
  def new(max_worker_count) do
    %WorkerPool{max_worker_count: max_worker_count}
  end

  @spec add_worker(WorkerPool.t(), WorkerPool.Worker.t()) :: WorkerPool.t()
  def add_worker(
        %WorkerPool{workers: workers} = worker_pool,
        %Worker{} = worker
      ) do
    %{worker_pool | workers: [worker | workers]}
  end

  @spec available_workers(WorkerPool.t()) :: non_neg_integer()
  def available_workers(%WorkerPool{
        max_worker_count: max_worker_count,
        workers: workers
      }),
      do: max_worker_count - Enum.count(workers)

  @spec next_step(WorkerPool.t()) :: {non_neg_integer(), WorkerPool.t()}
  def next_step(%WorkerPool{workers: workers} = worker_pool) do
    workers
    |> Enum.reduce(
      {[], []},
      fn %Worker{char: char, seconds_to_complete: seconds},
         {completed_chars, remaining_workers} ->
        if seconds == 1 do
          {[char | completed_chars], remaining_workers}
        else
          worker = %Worker{char: char, seconds_to_complete: seconds - 1}
          {completed_chars, [worker | remaining_workers]}
        end
      end
    )
    |> then(fn {chars, workers} ->
      {chars, %{worker_pool | workers: workers}}
    end)
  end
end
