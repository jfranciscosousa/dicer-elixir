defmodule RollStatsTest do
  use ExUnit.Case

  alias Dicer.RollStats

  test "rolls 6 stats between a sum of 70 and 80" do
    stats = RollStats.call()

    assert length(stats) == 6
    assert sum(stats) <= 80
    assert sum(stats) >= 70
  end
end
