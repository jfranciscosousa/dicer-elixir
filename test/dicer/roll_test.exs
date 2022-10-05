defmodule RollTest do
  use ExUnit.Case

  alias Dicer.Roll

  test "rolls one dice" do
    {:ok, expression, total} = Roll.call("1d4")

    assert is_bitstring(expression)
    assert total >= 1
    assert total <= 4
  end

  test "rolls many dice" do
    {:ok, expression, total} = Roll.call("2d4 + 2d4")

    assert is_bitstring(expression)
    assert is_number(total)
    assert total >= 4
    assert total <= 16
  end
end
