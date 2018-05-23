defmodule ElixirWeatherScraper.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixir_weather_scraper,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {ElixirWeatherScraper.Application, []}
    ]
  end

  defp deps do
    [
      {:floki, "~> 0.20.0"},
      {:table, "~> 0.0.5"},
      {:httpoison, "~> 1.0"}
    ]
  end
end
