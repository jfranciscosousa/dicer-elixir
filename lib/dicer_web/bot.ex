defmodule DicerWeb.Bot do
  require Logger

  use Nostrum.Consumer

  alias Nostrum.Api

  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def start(_type, _args) do
    start_link()
  end

  def handle_event({:MESSAGE_CREATE, msg, _ws_state}) do
    try do
      case DicerWeb.MessageCreate.call(msg.content, msg) do
        {:ok, :ignore} ->
          :ignore

        {:ok, _} ->
          Logger.info("successfull command \"#{msg.content}\"")

        {:error, error} ->
          Api.create_message(
            msg.channel_id,
            "I've blown up and can't deal with this by myself."
          )

          Logger.error(error)
      end
    rescue
      e in RuntimeError ->
        Api.create_message(
          msg.channel_id,
          "I've blown up and can't deal with this by myself. "
        )

        Logger.error(e)
    end
  end

  def handle_event(_event) do
    :noop
  end
end
