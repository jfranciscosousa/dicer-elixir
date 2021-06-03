defmodule FormatUtilsTest do
  use ExUnit.Case

  alias Dicer.FormatUtils

  test "user_to_tag/1" do
    assert FormatUtils.user_to_tag(%{id: "123"}) == "<@123>"
  end
end
