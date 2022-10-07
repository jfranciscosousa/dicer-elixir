defmodule DicerBot.InteractionCreate do
  alias DicerBot.InteractionCreate.{RollHandler, RollStatsHandler}

  alias Nostrum.Struct.{
    Interaction,
    ApplicationCommandInteractionData,
    ApplicationCommandInteractionDataOption
  }

  def call(
        %Interaction{
          data: %ApplicationCommandInteractionData{
            name: "roll",
            options: [
              %ApplicationCommandInteractionDataOption{
                value: expression
              }
            ]
          }
        } = interaction
      ) do
    RollHandler.call(expression, interaction)
  end

  def call(%Interaction{data: %{name: "roll_stats"}} = interaction) do
    RollStatsHandler.call(interaction)
  end

  @spec call(Interaction.t()) :: {:ok} | {:error, any()}
  def call(_) do
    {:ok}
  end
end
