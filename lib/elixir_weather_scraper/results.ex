defmodule ElixirWeatherScraper.Results do
  use Agent

  @me __MODULE__

  def start_link(_opts) do
    Agent.start_link(fn -> %{} end, name: @me)
  end

  def put(key, value) do
    Agent.update(@me, &Map.put(&1, key, value))
  end

  def get_results() do
    Agent.get(@me, fn map -> map end)
  end
end
