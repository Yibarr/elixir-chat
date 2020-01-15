defmodule Pokemeet.AccountsTest do
  use Pokemeet.DataCase

  alias Pokemeet.Accounts

  describe "users" do
    alias Pokemeet.Accounts.User

    @valid_attrs %{mail: "some mail", password: "some password", password_hash: "some password_hash", token: "some token", username: "some username"}
    @update_attrs %{mail: "some updated mail", password: "some updated password", password_hash: "some updated password_hash", token: "some updated token", username: "some updated username"}
    @invalid_attrs %{mail: nil, password: nil, password_hash: nil, token: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.mail == "some mail"
      assert user.password == "some password"
      assert user.password_hash == "some password_hash"
      assert user.token == "some token"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.mail == "some updated mail"
      assert user.password == "some updated password"
      assert user.password_hash == "some updated password_hash"
      assert user.token == "some updated token"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
