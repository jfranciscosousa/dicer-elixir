defmodule DicerBot.Application do
  require Logger

  alias DicerBot.CommandRegistry
  alias DicerBot.Utils.Discord

  use Nostrum.Consumer

  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def start(_type, _args) do
    start_link()
  end

  def handle_event({:INTERACTION_CREATE, interaction, _ws_state}) do
    Logger.info("incoming command #{interaction.data.name}")

    try do
      case DicerBot.InteractionCreate.call(interaction) do
        {:ok} ->
          Logger.info("successfull command \"#{interaction.data.name}\"")

        {:ok, :ignore} ->
          Logger.info("ignored command \"#{interaction.data.name}\"")

        {:error, error} ->
          Discord.simple_interaction_response(
            interaction,
            "I've blown up and can't deal with this by myself."
          )

          Logger.error(error)
      end
    rescue
      e in RuntimeError ->
        Discord.simple_interaction_response(
          interaction,
          "I've blown up and can't deal with this by myself."
        )

        Logger.error(e)
    end
  end

  def handle_event({:READY, event, _}) do
    CommandRegistry.call(event)
  end

  def handle_event(_event) do
    :noop
  end
end
