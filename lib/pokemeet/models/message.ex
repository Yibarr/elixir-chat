defmodule Pokemeet.Message do
  use Pokemeet.Model

  alias Pokemeet.{Conversation, User, ConversationUser}

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
    |> validate_user_in_conversation(:user_id)
    |> foreign_key_constraint(:conversation_id)
    |> foreign_key_constraint(:user_id)
  end

  defp validate_user_in_conversation(changeset, field) do
    validate_change(changeset, field, fn _, user_id ->
      case ConversationUser.find_by(%{
             conversation_id: changeset.changes[:conversation_id],
             user_id: user_id
           }) do
        nil -> [{field, "is not in conversation"}]
        _ -> []
      end
    end)
  end

end
