defmodule Dicer.Utils.Format do
  alias Nostrum.Struct.User

  @spec user_to_tag(User.t()) :: String.t()
  def user_to_tag(user) do
    "<@#{user.id}>"
  end
end
