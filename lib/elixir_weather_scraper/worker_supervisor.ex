defmodule ElixirWeatherScraper.WorkerSupervisor do
  use DynamicSupervisor

  @me __MODULE__

  def start_link(_) do
    DynamicSupervisor.start_link(__MODULE__, :no_args, name: @me)
  end

  def init(:no_args) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def add_worker() do
    IO.puts("add worker")
    {:ok, _pid} = DynamicSupervisor.start_child(@me, ElixirWeatherScraper.Worker)
  end
end
