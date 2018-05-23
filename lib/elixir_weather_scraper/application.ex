defmodule ElixirWeatherScraper.Application do
  use Application

  def start(_type, _args) do
    children = [
      ElixirWeatherScraper.Results,
      ElixirWeatherScraper.UrlFinder,
      ElixirWeatherScraper.WorkerSupervisor,
      {ElixirWeatherScraper.Gatherer, 15}
    ]

    opts = [strategy: :one_for_one, name: ElixirWeatherScraper.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
