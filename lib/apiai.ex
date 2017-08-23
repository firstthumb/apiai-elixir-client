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

  def get_intent(intent_id) do
    client() |> ApiAi.Intent.get_intent(intent_id)
  end

  def delete_intent(intent_id) do
    client() |> ApiAi.Intent.delete_intent(intent_id)
  end

  def add_intent(name, requests, responses \\ [], contexts_in \\ [], contexts_out \\ []) do
    client() |> ApiAi.Intent.add_intent(name, requests, responses, contexts_in, contexts_out)
  end

  def save_intent(intent_id, name, requests, responses \\ [], contexts_in \\ [], contexts_out \\ []) do
    client() |> ApiAi.Intent.save_intent(intent_id, name, requests, responses, contexts_in, contexts_out)
  end
end
