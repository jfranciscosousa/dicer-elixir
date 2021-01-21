defmodule DicerWeb.MessageCreate.RollHandler do
  alias Nostrum.Api
  alias Dicer.Roll

  def call(input, msg) do
    author = msg.author.username

    with {:ok, expression, total} <- Roll.call(input),
         response <- "#{expression} = #{total} by #{author}" do
      if String.length(response) >= 2000 do
        Api.create_message(msg.channel_id, "#{total} by #{author}")
      else
        Api.create_message(msg.channel_id, response)
      end
    else
      {:error, _} ->
        Api.create_message(
          msg.channel_id,
          "Can't roll that my friend #{author}"
        )
    end
  end
end
