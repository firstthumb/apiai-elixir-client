defmodule ApiAi.Query do
  @derive Poison.Encoder

  defstruct [:query, :contexts , :location, :timezone, :lang, :sessionId]

  def event(client, event_name, event_data \\ %{}, session_id, contexts \\ [], location \\ nil, lang \\ "en", timezone \\ "America/New_York") do
    payload = %{
      event: %{
        name: event_name,
        data: event_data
      },
      contexts: contexts,
      location: location,
      timezone: timezone,
      lang: lang,
      sessionId: session_id
    }

    case ApiAi.Client.post(client, "query", Poison.encode!(payload), :empty, false) do
      {:ok, %HTTPoison.Response{body: body}} ->
        {:ok, get_result(body)}
      {:error, error} ->
        {:error, error}
    end
  end

  def query(client, query_text, session_id, contexts \\ [], location \\ nil, lang \\ "en", timezone \\ "America/New_York") do
    payload = %{
      query: query_text,
      contexts: contexts,
      location: location,
      timezone: timezone,
      lang: lang,
      sessionId: session_id
    }

    case ApiAi.Client.post(client, "query", Poison.encode!(payload), :empty, false) do
      {:ok, %HTTPoison.Response{body: body}} ->
        {:ok, get_result(body)}
      {:error, error} ->
        {:error, error}
    end
  end

  def get_result(response) do
    %{
      speech: response["result"]["fulfillment"]["speech"],
      messages: response["result"]["fulfillment"]["messages"]
    }
  end
end
