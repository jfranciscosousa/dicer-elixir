defmodule ClearTest do
  use ExUnit.Case

  alias DicerWeb.MessageCreate.ClearHandler
  alias Nostrum.Api

  import Mock

  test "only deletes commands for the bot and it's responses" do
    channel_id = 420
    bot_id = 666

    messages = [
      %{id: 1, content: "!roll 1d20", author: %{id: 1}},
      %{id: 2, content: "!dicer roll 1d20", author: %{id: 1}},
      %{id: 3, content: "!roll_stats", author: %{id: 1}},
      %{id: 4, content: "!dicer roll_stats", author: %{id: 1}},
      %{id: 5, content: "!clear", author: %{id: 1}},
      %{id: 6, content: "!dicer clear", author: %{id: 1}},
      %{id: 7, content: "4 + 4 = 8", author: %{id: bot_id}},
      %{id: 8, content: "hey dude how are you", author: %{id: 1}},
      %{id: 9, content: "!rollsfromanothercomand", author: %{id: 1}},
      %{id: 10, content: "!clearfromanothercomand", author: %{id: 1}}
    ]

    with_mocks([
      {Nostrum.Api, [],
       [
         get_channel_messages: fn _, _ -> {:ok, messages} end,
         bulk_delete_messages: fn _, _ -> {:ok} end
       ]},
      {Nostrum.Cache.Me, [], [get: fn -> %{id: bot_id} end]}
    ]) do
      ClearHandler.call(%{channel_id: channel_id})

      assert_called(Api.bulk_delete_messages(channel_id, [1, 2, 3, 4, 5, 6, 7]))
    end
  end
end
