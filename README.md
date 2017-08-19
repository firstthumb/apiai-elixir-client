[![Build Status](https://travis-ci.org/firstthumb/apiai-elixir-client.svg?branch=master)](https://travis-ci.org/firstthumb/apiai-elixir-client)

# Apiai

It is an Elixir client library for the Api.ai API.

## Features

Apiai Elixir client currently supports:

  1. Do query `ApiAi.query/6`

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

Write your Api.ai credentials to config file

```elixir
config :apiai,
    client_access_token: "CLIENT_ACCESS_TOKEN_HERE",
    developer_access_token: "DEVELOPER_ACCESS_TOKEN_HERE"
```


```elixir
case ApiAi.query "Hi", "session_id" do
  {:ok, response} ->
    IO.inspect response
  {:error, error}
    IO.inspect error
end
```
