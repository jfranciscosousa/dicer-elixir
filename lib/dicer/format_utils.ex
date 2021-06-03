defmodule Dicer.FormatUtils do
  def user_to_tag(user) do
    "<@#{user.id}>"
  end
end
