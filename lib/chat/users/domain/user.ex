defmodule Chat.Users.User do
  @moduledoc """
  Represents single User
  """

  use Ecto.Schema
  import Ecto.Changeset

  @type t() :: %__MODULE__{
          id: integer(),
          name: String.t(),
          email: String.t()
        }

  schema "users" do
    field :name, :string
    field :email, :string

    timestamps()
  end

  @spec changeset(t(), map()) :: Ecto.Changeset.t()
  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :name,
      :email
    ])
    |> validate_required([
      :name,
      :email
    ])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end
end
