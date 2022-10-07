defmodule DicerBot.Utils.Discord do
  alias Nostrum.Struct.Interaction

  @spec simple_interaction_response(Interaction.t(), String.t()) ::
          {:ok} | {:error, any()}
  def simple_interaction_response(interaction, message) do
    Nostrum.Api.create_interaction_response(
      interaction,
      %{
        type: 4,
        data: %{
          content: message
        }
      }
    )
  end
end
