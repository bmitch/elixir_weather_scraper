defmodule ElixirWeatherScraper.Worker do
  use GenServer, restart: :transient

  def start_link(_) do
    GenServer.start_link(__MODULE__, :no_args)
  end

  def init(:no_args) do
    Process.send_after(self(), :do_one_url, 0)
    {:ok, nil}
  end

  def handle_info(:do_one_url, _) do
    ElixirWeatherScraper.UrlFinder.next_url()
    |> add_result()
  end

  defp add_result([]) do
    ElixirWeatherScraper.Gatherer.done()
    {:noreply, []}
  end

  defp add_result({location, url}) do
    url
    |> HTTPoison.get()
    |> parse_response()
    |> add_result(location)

    send(self(), :do_one_url)
    {:noreply, nil}
  end

  defp parse_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    [{_span, [_class], temp_list}] =
      Floki.find(body, "#current_obs .current_obs tr:nth-child(2) span.bold")

    List.to_string(temp_list)
  end

  defp add_result(temp, location) do
    ElixirWeatherScraper.Gatherer.result(location, temp)
  end
end
