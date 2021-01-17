defmodule DicerWeb.MessageCreate do
  alias DicerWeb.MessageCreate.{ClearHandler, RollHandler, RollStatsHandler}

  def call("!roll " <> input, msg) do
    RollHandler.call(input, msg)
  end

  def call("!dicer roll " <> input, msg) do
    RollHandler.call(input, msg)
  end

  def call("!roll_stats", msg) do
    RollStatsHandler.call(msg)
  end

  def call("!dicer roll_stats", msg) do
    RollStatsHandler.call(msg)
  end

  def call("!clear", msg) do
    ClearHandler.call(msg)
  end

  def call("!dicer clear", msg) do
    ClearHandler.call(msg)
  end

  def call(_, _msg) do
    {:ok, :ignore}
  end
end
