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
      {:abacus, "~> 2.0.0"},
      {:cowlib, "~> 2.11.1",
       [
         env: :prod,
         hex: "remedy_cowlib",
         repo: "hexpm",
         optional: false,
         override: true
       ]},
      {:plug_cowboy, "~> 2.5.2"},
      {:mock, "~> 0.3.7", only: :test},
      {:nostrum, "~> 0.6.1"}
    ]
  end
end
