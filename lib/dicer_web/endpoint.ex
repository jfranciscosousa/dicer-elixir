defmodule DicerWeb.Endpoint do
  use Plug.Router

  @template_dir "lib/dicer_web/templates"
  @public_dir "lib/dicer_web/public"
  @invite_url "https://discord.com/oauth2/authorize?client_id=#{
                Application.get_env(:dicer, :client_id)
              }&scope=bot"

  plug(Plug.Logger)
  plug(Plug.Static, at: "/static", from: {:dicer, @public_dir})
  plug(:match)
  plug(:dispatch)

  get "/" do
    render(conn, "index.html", invite_url: @invite_url)
  end

  match _ do
    send_resp(conn, 404, "")
  end

  defp render(%{status: status} = conn, template, assigns) do
    body =
      @template_dir
      |> Path.join(template)
      |> String.replace_suffix(".html", ".html.eex")
      |> EEx.eval_file(assigns)

    send_resp(conn, status || 200, body)
  end
end
