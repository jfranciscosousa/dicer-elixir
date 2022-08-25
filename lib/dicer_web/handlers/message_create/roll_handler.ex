defmodule DicerWeb.MessageCreate.RollHandler do
  alias Nostrum.Api
  alias Dicer.Roll
  alias Dicer.Utils.Format

  def call(input, msg) do
    author = Format.user_to_tag(msg.author)

    with {:ok, expression, total} <- Roll.call(input),
         response <- "#{expression} = #{total} by #{author}" do
      if String.length(response) >= 2000 do
        Api.create_message(msg.channel_id, "#{total} by #{author}")
      else
        Api.create_message(msg.channel_id, response)
      end
    else
      {:error, error} ->
        Api.create_message(
          msg.channel_id,
          "#{error} #{author}"
        )
    end
  end
end
