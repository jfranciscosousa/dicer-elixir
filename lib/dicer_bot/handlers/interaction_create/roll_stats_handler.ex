defmodule DicerBot.InteractionCreate.RollStatsHandler do
  alias Dicer.RollStats
  alias Dicer.Utils.Format
  alias DicerBot.Utils.Discord

  @spec call(Interaction.t()) :: {:ok} | {:error, any()}
  def call(interaction) do
    author = Format.user_to_tag(interaction.user)

    with {:ok, result} <- RollStats.call(),
         result <- result |> Enum.map(&to_string/1) |> Enum.join("  "),
         response <- "#{author} your stats are: #{result}\n\nHave a nice game!" do
      Discord.simple_interaction_response(interaction, response)
    else
      {:error, :max_iterations} ->
        Discord.simple_interaction_response(
          interaction,
          "A cosmic ray has blown up the algorithm. Try again, it won't hurt. I swear it."
        )
    end
  end
end
