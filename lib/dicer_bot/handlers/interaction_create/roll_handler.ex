defmodule DicerBot.InteractionCreate.RollHandler do
  alias Dicer.Roll
  alias Dicer.Utils.Format
  alias DicerBot.Utils.Discord

  def call(input, interaction) do
    author = Format.user_to_tag(interaction.user)

    with {:ok, expression, total} <- Roll.call(input),
         response <- "#{author} rolled #{input}\n\n#{expression} = #{total}" do
      if String.length(response) >= 500 do
        Discord.simple_interaction_response(
          interaction,
          "#{author} rolled #{input}\n\n Total:#{total}"
        )
      else
        Discord.simple_interaction_response(interaction, response)
      end
    else
      {:error, error} ->
        Discord.simple_interaction_response(
          interaction,
          "#{error} #{author}"
        )
    end
  end
end
