defmodule ApiAi do
  @version "0.1.0"
  def version, do: @version

  def client do
    %ApiAi.Client{
        client_access_token: Application.get_env(:apiai, :client_access_token),
        developer_access_token: Application.get_env(:apiai, :developer_access_token)
    }
  end

  def query(query_text, session_id, contexts \\ [], location \\ nil, lang \\ "en", timezone \\ "America/New_York") do
    client() |> ApiAi.Query.query(query_text, session_id, contexts, location, lang, timezone)
  end
end
