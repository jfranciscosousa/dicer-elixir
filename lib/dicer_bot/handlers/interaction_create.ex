defmodule DicerBot.InteractionCreate do
  alias DicerBot.InteractionCreate.{RollHandler, RollStatsHandler}
  alias Nostrum.Struct.Interaction

  def call(
        %Interaction{data: %{name: "roll", options: [%{value: expression}]}} =
          interaction
      ) do
    RollHandler.call(expression, interaction)
  end

  def call(%Interaction{data: %{name: "roll_stats"}} = interaction) do
    RollStatsHandler.call(interaction)
  end

  def call(_, _msg) do
    {:ok, :ignore}
  end
end
