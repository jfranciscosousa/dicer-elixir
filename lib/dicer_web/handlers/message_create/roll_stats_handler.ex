defmodule DicerWeb.MessageCreate.RollStatsHandler do
  alias Nostrum.Api
  alias Dicer.RollStats
  alias Dicer.Utils.Format

  def call(msg) do
    author = Format.user_to_tag(msg.author)

    with {:ok, result} <- RollStats.call(),
         result <- result |> Enum.map(&to_string/1) |> Enum.join("  "),
         response <- "#{author} your stats are: #{result}\n\nHave a nice game!" do
      Api.create_message(msg.channel_id, response)
    else
      {:error, :max_iterations} ->
        Api.create_message(
          msg.channel_id,
          "A cosmic ray has blown up the algorithm. Try again, it won't hurt. I swear"
        )
    end
  end
end
