defmodule Pokemeet.Trainers.Users do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string, unique: true
    field :password, :string
    field :password_hash, :string, virtual: true
    field :token, :string
    field :username, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(users, attrs) do
    users
    |> cast(attrs, [:username, :email, :password])
    |> validate_required([:username, :email, :password])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> hash_password()
  end

  defp hash_password(changeset) do
    changeset
  end
end
