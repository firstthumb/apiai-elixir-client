defmodule ApiAi.Intent do
  @derive Poison.Encoder

  defstruct [:name, :auto, :contexts, :templates, :userSays, :responses, :priority]

  def get_all_intents(client) do
    case ApiAi.Client.get(client, "intents") do
      {:ok, %HTTPoison.Response{body: body}} ->
        {:ok, body}
      {:error, error} ->
        {:error, error}
    end
  end

  def get_intent(client, intent_id) do
    case ApiAi.Client.get(client, "intents/#{intent_id}") do
      {:ok, %HTTPoison.Response{body: body}} ->
        {:ok, body}
      {:error, error} ->
        {:error, error}
    end
  end

  def delete_intent(client, intent_id) do
    case ApiAi.Client.delete(client, "intents/#{intent_id}") do
      {:ok, %HTTPoison.Response{body: body}} ->
        if body["status"]["code"] == 200 do
          {:ok, body}
        else
          {:error, body}
        end
      {:error, error} ->
        {:error, error}
    end
  end

  def add_intent(client, name, requests, responses \\ [], contexts_in \\ [], contexts_out \\ []) do
    payload = get_payload(name, requests, responses, contexts_in, contexts_out)

    case ApiAi.Client.post(client, "intents", Poison.encode!(payload), :empty, false) do
      {:ok, %HTTPoison.Response{body: body}} ->
        if body["status"]["code"] == 200 do
          {:ok, body}
        else
          {:error, body}
        end
      {:error, error} ->
        {:error, error}
    end
  end

  def save_intent(client, intent_id, name, requests, responses \\ [], contexts_in \\ [], contexts_out \\ []) do
    payload = get_payload(name, requests, responses, contexts_in, contexts_out)

    case ApiAi.Client.put(client, "intents/#{intent_id}", Poison.encode!(payload), :empty, false) do
      {:ok, %HTTPoison.Response{body: body}} ->
        if body["status"]["code"] == 200 do
          {:ok, body}
        else
          {:error, body}
        end
      {:error, error} ->
        {:error, error}
    end
  end

  def get_payload(name, requests, responses \\ [], contexts_in \\ [], contexts_out \\ []) do
    %{
      name: name,
      auto: true,
      contexts: contexts_in,
      templates: requests,
      userDays: [
        %{
            data: requests |> Enum.chunk(1) |> Enum.map(fn [a] -> %{text: a} end)
        }
      ],
      responses: [
        %{
            resetContexts: false,
            action: "",
            affectedContexts: contexts_out |> Enum.chunk(1) |> Enum.map(fn [a] -> %{name: a, lifespan: 10} end),
            parameters: [
            ],
            messages: [
                %{type: 0, speech: responses}
            ]
        }
      ],
      priority: 500000
    }
  end
end
