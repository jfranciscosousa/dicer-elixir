defmodule Dicer do
  use Application

  def start(_type, _args) do
    children = [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: DicerWeb.Endpoint,
        options: [port: System.get_env("PORT", "4000") |> String.to_integer()]
      ),
      DicerWeb.Bot
    ]

    opts = [strategy: :one_for_one, name: :dicer]

    Supervisor.start_link(children, opts)
  end
end
