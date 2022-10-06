defmodule DicerBot.CommandRegistry do
  def call(event) do
    clear_global_application_commands()
    Enum.each(event.guilds, &register_commands/1)
  end

  defp register_commands(guild) do
    clear_guild_application_commands(guild.id)

    Nostrum.Api.create_global_application_command(%{
      name: "roll",
      description: "Roll dice!",
      options: [
        %{
          name: "expression",
          description: "the expression you want to roll. eg: 1d20 + 8",
          type: 3,
          required: true
        }
      ]
    })

    Nostrum.Api.create_global_application_command(%{
      name: "roll_stats",
      description: "Roll stats for a your character!",
      options: []
    })
  end

  defp clear_global_application_commands() do
    with {:ok, commands} <- Nostrum.Api.get_global_application_commands(),
         Enum.each(commands, fn command ->
           Nostrum.Api.delete_global_application_command(command.id)
         end) do
      {:ok}
    else
      error -> throw(error)
    end
  end

  defp clear_guild_application_commands(guild_id) do
    with {:ok, commands} <-
           Nostrum.Api.get_guild_application_commands(guild_id),
         Enum.each(commands, fn command ->
           Nostrum.Api.delete_guild_application_command(guild_id, command.id)
         end) do
      {:ok}
    else
      error -> throw(error)
    end
  end
end
