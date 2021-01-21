defmodule DicerWeb.MessageCreate.ClearHandler do
  alias Nostrum.Api

  @commands_regexes [
    ~r/^!roll$/,
    ~r/^!roll .*$/,
    ~r/^!roll_stats$/,
    ~r/^!clear$/,
    ~r/^!dicer roll .*$/,
    ~r/^!dicer roll_stats$/,
    ~r/^!dicer clear$/
  ]

  def call(msg) do
    with {:ok, messages_to_delete} <-
           Api.get_channel_messages(msg.channel_id, :infinity),
         messages_to_delete <-
           Enum.filter(messages_to_delete, &eligible_message?/1),
         messages_to_delete_only_ids <-
           Enum.map(messages_to_delete, fn message -> message.id end),
         {:ok} <-
           Api.bulk_delete_messages(msg.channel_id, messages_to_delete_only_ids) do
      {:ok, :deleted}
    else
      {:error, error} -> {:error, error}
    end
  end

  defp eligible_message?(msg) do
    is_command =
      Enum.find(@commands_regexes, fn regex ->
        Regex.match?(regex, msg.content)
      end)

    is_bot_response = msg.author.id == Nostrum.Cache.Me.get().id

    is_command || is_bot_response
  end
end
