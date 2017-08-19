defmodule ApiAi.Client do
  use HTTPoison.Base

  defstruct client_access_token: nil, developer_access_token: nil

  @type t :: %__MODULE__{
    client_access_token: String.t,
    developer_access_token: String.t
  }

  @api_version "20150910"
  @user_agent "elixir-client"

  def request(client, method, path, params, body, headers, authenticated) do
    params = add_default_parameters(client, params, authenticated)
    headers = add_default_headers(client, headers, authenticated)

    url = url(path, params)
    request(method, url, body, headers, [])
  end

  def get(client, path, params \\ :empty, authenticated \\ false) do
    request(client, :get, path, params, "", [], authenticated)
  end

  def post(client, path, body, params \\ :empty, authenticated \\ false) do
    request(client, :post, path, params, body, [], authenticated)
  end

  def process_response_body(body) do
    body
    |> Poison.decode!
  end

  # Helpers

  defp add_default_headers(client, headers, _authenticated) do
    [user_agent_header(), auth_token_header(client), content_type_json()] ++ headers
  end

  defp add_default_parameters(_client, :empty, _authenticated) do
    [ v: @api_version]
  end
  defp add_default_parameters(_client, params, _authenticated) do
    [ v: @api_version] ++ params
  end

  defp user_agent_header() do
    {"User-Agent", "#{@user_agent}/#{ApiAi.version}"}
  end

  defp auth_token_header(client) do
    {"Authorization", "Bearer #{client.client_access_token}"}
  end

  defp content_type_json() do
    {"Content-Type", "application/json"}
  end

  defp url(path, :empty), do: "https://api.api.ai/v1/" <> path
  defp url(path, params) do
    uri =
    url(path, :empty)
    |> URI.parse
    |> Map.put(:query, Plug.Conn.Query.encode(params))
    URI.to_string(uri)
  end
end
