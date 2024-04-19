defmodule Chat.Users.Repositories.UserRepoTest do
  use Chat.DataCase

  alias Chat.Users.User
  alias Chat.Users.Repositories.UserRepo

  describe "store user" do
    test "stores user" do
      {:ok, user} = UserRepo.store(%User{}, %{name: "Jon", email: "jon@snow.com"})
      assert Repo.get(User, user.id) == user
    end

    test "does not store user without name" do
      {:error, user} = UserRepo.store(%User{}, %{name: "", email: "jon@snow.com"})
      assert user.valid? == false
    end

    test "does not store user without email" do
      {:error, user} = UserRepo.store(%User{}, %{name: "Jon", email: ""})
      assert user.valid? == false
    end

    test "does not store user with already existing email" do
      UserRepo.store(%User{}, %{name: "Jon", email: "jon@snow.com"})
      {:error, user} = UserRepo.store(%User{}, %{name: "Ned", email: "jon@snow.com"})
      assert user.valid? == false
    end
  end
end
