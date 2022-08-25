import Config

config :nostrum,
  token: System.get_env("DISCORD_TOKEN"),
  num_shards: :auto

config :dicer,
  client_id: System.get_env("DISCORD_CLIENT_ID"),
  port: System.get_env("PORT", "4000") |> String.to_integer()
