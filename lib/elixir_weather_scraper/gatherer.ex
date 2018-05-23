defmodule ElixirWeatherScraper.Gatherer do
  use GenServer

  @me __MODULE__

  # api
  def start_link(worker_count) do
    GenServer.start_link(__MODULE__, worker_count, name: @me)
  end

  def done() do
    GenServer.cast(@me, :done)
  end

  def result(location, temp) do
    GenServer.cast(@me, {:result, location, temp})
  end

  # server
  def init(worker_count) do
    Process.send_after(self(), :kickoff, 0)
    {:ok, worker_count}
  end

  def handle_info(:kickoff, worker_count) do
    1..worker_count
    |> Enum.each(fn _ -> ElixirWeatherScraper.WorkerSupervisor.add_worker() end)

    {:noreply, worker_count}
  end

  def handle_cast(:done, _worker_count = 1) do
    report_results()
    System.halt(0)
  end

  def handle_cast(:done, worker_count) do
    {:noreply, worker_count - 1}
  end

  def handle_cast({:result, location, temp}, worker_count) do
    ElixirWeatherScraper.Results.put(location, temp)
    {:noreply, worker_count}
  end

  defp report_results() do
    results = ElixirWeatherScraper.Results.get_results()
    IO.write("\n")
    IO.write(Table.table(results))
  end
end
