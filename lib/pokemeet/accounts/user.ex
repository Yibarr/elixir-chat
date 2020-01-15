defmodule Pokemeet.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string, unique: true
    field :password, :string, virtual: true
    field :password_hash, :string
    field :token, :string, virtual: true
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password])
    |> validate_required([:username, :email, :password])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> put_password_hash
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, Bcrypt.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
