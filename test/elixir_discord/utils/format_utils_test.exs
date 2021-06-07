defmodule UtilsFormatTest do
  use ExUnit.Case

  alias Dicer.Utils.Format

  test "user_to_tag/1" do
    assert Format.user_to_tag(%{id: "123"}) == "<@123>"
  end
end
