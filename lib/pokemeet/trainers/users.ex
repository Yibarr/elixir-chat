defmodule Pokemeet.Trainers.Users do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :password, :string
    field :password_hash, :string
    field :token, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(users, attrs) do
    users
    |> cast(attrs, [:username, :email, :password, :password_hash, :token])
    |> validate_required([:username, :email, :password, :password_hash, :token])
  end
end
