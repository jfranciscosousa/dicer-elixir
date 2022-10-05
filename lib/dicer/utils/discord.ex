defmodule Dicer.Utils.Discord do
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
