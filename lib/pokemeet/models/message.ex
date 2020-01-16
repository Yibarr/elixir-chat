defmodule Pokemeet.Message do
  use Ecto.Schema
  import Ecto.Changeset

  alias Pokemeet.{Conversation, ConversationUser, User}

  schema "messages" do
    field :body, :string

    belongs_to :conversation, Conversation
    belongs_to :user, User

    timestamps()
  end

  def changeset(message, attrs) do
    message
    |> cast(attrs, [:body, :conversation_id, :user_id])
    |> validate_required([:body, :conversation_id, :user_id])
    |> foreign_key_constraint(:conversation_id)
    |> foreign_key_constraint(:user_id)
  end

end
