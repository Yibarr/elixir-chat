defmodule Pokemeet.TrainersTest do
  use Pokemeet.DataCase

  alias Pokemeet.Trainers

  describe "users" do
    alias Pokemeet.Trainers.Users

    @valid_attrs %{
      email: "some email",
      password: "some password",
      password_hash: "some password_hash",
      token: "some token",
      username: "some username"
    }
    @update_attrs %{
      email: "some updated email",
      password: "some updated password",
      password_hash: "some updated password_hash",
      token: "some updated token",
      username: "some updated username"
    }
    @invalid_attrs %{email: nil, password: nil, password_hash: nil, token: nil, username: nil}

    def users_fixture(attrs \\ %{}) do
      {:ok, users} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Trainers.create_users()

      users
    end

    test "list_users/0 returns all users" do
      users = users_fixture()
      assert Trainers.list_users() == [users]
    end

    test "get_users!/1 returns the users with given id" do
      users = users_fixture()
      assert Trainers.get_users!(users.id) == users
    end

    test "create_users/1 with valid data creates a users" do
      assert {:ok, %Users{} = users} = Trainers.create_users(@valid_attrs)
      assert users.email == "some email"
      assert users.password == "some password"
      assert users.password_hash == "some password_hash"
      assert users.token == "some token"
      assert users.username == "some username"
    end

    test "create_users/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Trainers.create_users(@invalid_attrs)
    end

    test "update_users/2 with valid data updates the users" do
      users = users_fixture()
      assert {:ok, %Users{} = users} = Trainers.update_users(users, @update_attrs)
      assert users.email == "some updated email"
      assert users.password == "some updated password"
      assert users.password_hash == "some updated password_hash"
      assert users.token == "some updated token"
      assert users.username == "some updated username"
    end

    test "update_users/2 with invalid data returns error changeset" do
      users = users_fixture()
      assert {:error, %Ecto.Changeset{}} = Trainers.update_users(users, @invalid_attrs)
      assert users == Trainers.get_users!(users.id)
    end

    test "delete_users/1 deletes the users" do
      users = users_fixture()
      assert {:ok, %Users{}} = Trainers.delete_users(users)
      assert_raise Ecto.NoResultsError, fn -> Trainers.get_users!(users.id) end
    end

    test "change_users/1 returns a users changeset" do
      users = users_fixture()
      assert %Ecto.Changeset{} = Trainers.change_users(users)
    end
  end
end
