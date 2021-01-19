defmodule Dicer do
  use Application

  def start(_type, _args) do
    children = [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: DicerWeb.Endpoint,
        options: [
          port: Application.get_env(:dicer, :port)
        ]
      ),
      DicerWeb.Bot
    ]

    opts = [strategy: :one_for_one, name: :dicer]

    Supervisor.start_link(children, opts)
  end
end
