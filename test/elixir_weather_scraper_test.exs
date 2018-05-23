defmodule ElixirWeatherScraperTest do
  use ExUnit.Case
  doctest ElixirWeatherScraper

  test "greets the world" do
    assert ElixirWeatherScraper.hello() == :world
  end
end
