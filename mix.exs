defmodule Apiai.Mixfile do
  use Mix.Project

  def project do
    [
      app: :apiai,
      version: "0.1.0",
      elixir: "~> 1.5",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "ApiAI",
      source_url: "https://github.com/firstthumb/apiai-elixir-client"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 0.13"},
      {:poison, "~> 3.1"},
      {:plug, "~> 1.0"},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp description do
    """
    Integrate agents from the Api.ai natural language processing service with Elixir
    """
  end

  defp package do
    # These are the default files included in the package
    [
      name: :apiai,
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Erol Kocaman"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/firstthumb/apiai-elixir-client"}
    ]
  end
end
