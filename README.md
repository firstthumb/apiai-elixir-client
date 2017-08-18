# Apiai

It is an Elixir client library for the Api.ai API.

## Features

Apiai Elixir client currently supports:

  1. Do query `ApiAi.query/1`

Adding endpoints should be relatively simple, and I'm open to pull requests.

## Installation

The package can be installed as:

  1. Add apiai to your list of dependencies in `mix.exs`:

  ```elixir
  def deps do
    [
      {:apiai, "~> 0.1.0"}
    ]
  end
  ```

  2. Ensure apiai is started before your application:

  ```elixir
  def application do
    [applications: [:apiai]]
  end
  ```

## Usage

```elixir
client = %ApiAi.Client{
  client_access_token: "CLIENT_ACCESS_TOKEN_HERE",
  developer_access_token: "CLIENT_SECRET_HERE"
}

case ApiAi.query(client, "Hi", [{weather: 4}], "session_id") do
  {:ok, response} ->
    IO.inspect response
  {:error, error} ->
    IO.inspect error
end
```
