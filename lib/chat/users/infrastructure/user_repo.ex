defmodule Chat.Users.Repositories.UserRepo do
  @moduledoc """
  User database operations
  """

  alias Chat.Repo
  alias Chat.Users.User

  @spec store(User.t(), map()) :: {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  def store(user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
