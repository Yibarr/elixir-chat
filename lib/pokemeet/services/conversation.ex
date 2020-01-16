defmodule Pokemeet.Service.ConversationService do
  import Ecto.Query
  alias Pokemeet.{ConversationUser, Conversation, Repo}

  def all_for_user(user) do
    Repo.all(
      from c in Conversation,
        join: cu in ConversationUser,
        where: cu.conversation_id == c.id and cu.user_id == ^user.id,
        order_by: [desc: c.updated_at]
    )
  end

  def find_for_user(id, user) do
    Repo.one(
      from c in Conversation,
        join: cu in ConversationUser,
        where: c.id == ^id and cu.conversation_id == c.id and cu.user_id == ^user.id
    )
  end

  def find_for_users(user_ids) do
    query =
      user_ids
      |> Enum.filter(&(!is_nil(&1)))
      |> Enum.reduce(Conversation, fn user_id, query ->
        from c in query,
          join: cu in ConversationUser,
          where: cu.conversation_id == c.id and cu.user_id == ^user_id
      end)

    Repo.one(from q in query, limit: 1)
  end

  def user_ids(conversation_id) when is_number(conversation_id) do
    Repo.all(
      from cu in ConversationUser,
        where: cu.conversation_id == ^conversation_id,
        select: cu.user_id
    )
  end

  def user_ids(conversation) do
    Repo.all(
      from cu in ConversationUser,
        where: cu.conversation_id == ^conversation.id,
        select: cu.user_id
    )
  end

end
