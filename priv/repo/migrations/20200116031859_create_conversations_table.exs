defmodule Pokemeet.Repo.Migrations.CreateConversationsTable do
  use Ecto.Migration

  def change do
    create table(:conversations) do
      add :title, :string

      timestamps()
    end
  end
end
