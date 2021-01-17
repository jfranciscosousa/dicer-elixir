defmodule Dicer.MixProject do
  use Mix.Project

  def project do
    [
      app: :dicer,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Dicer, []}
    ]
  end

  defp deps do
    [
      {:abacus, "~> 0.4.2"},
      {:plug_cowboy, "~> 2.0"},
      {:mock, "~> 0.3.0", only: :test},
      {:nostrum, "~> 0.4"}
    ]
  end
end
