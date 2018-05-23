defmodule ElixirWeatherScraper.UrlFinder do
  use GenServer
  @me __MODULE__

  # API
  def start_link(_) do
    GenServer.start_link(__MODULE__, :no_args, name: @me)
  end

  def next_url() do
    GenServer.call(@me, :next_url)
  end

  # Server
  def init(_opts) do
    {:ok, get_init_urls()}
  end

  def handle_call(:next_url, _from, [head | tail]) do
    {:reply, head, tail}
  end

  def handle_call(:next_url, _from, []) do
    {:reply, [], []}
  end

  defp get_init_urls do
    [
      shawnigan: "http://www.victoriaweather.ca/station.php?id=93",
      kelsey: "http://www.victoriaweather.ca/station.php?id=103",
      slschool: "http://www.victoriaweather.ca/station.php?id=160",
      wishart: "http://www.victoriaweather.ca/station.php?id=57",
      lansdowne: "http://www.victoriaweather.ca/station.php?id=159",
      gnorfolk: "http://www.victoriaweather.ca/station.php?id=131",
      deepcode: "http://www.victoriaweather.ca/station.php?id=62",
      sidney: "http://www.victoriaweather.ca/station.php?id=67",
      kelsetelem: "http://www.victoriaweather.ca/station.php?id=174",
      calrevelle: "http://www.victoriaweather.ca/station.php?id=71",
      butchart: "http://www.victoriaweather.ca/station.php?id=42",
      ctvvictoria: "http://www.victoriaweather.ca/station.php?id=41",
      uvic: "http://www.victoriaweather.ca/station.php?id=143",
      vichigh: "http://www.victoriaweather.ca/station.php?id=8",
      johnmuir: "http://www.victoriaweather.ca/station.php?id=37"
    ]
  end
end
