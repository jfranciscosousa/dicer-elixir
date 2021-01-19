import Config

config :dicer,
  port: System.get_env("PORT", "4000") |> String.to_integer()
