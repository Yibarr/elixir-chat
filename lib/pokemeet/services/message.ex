defmodule Pokemeet.Service.MessageService do
  import Ecto.Query
  alias Pokemeet.{Message, Repo}

  def all_for_conversation(conversation) do
    Repo.all(
      from m in Message, where: m.conversation_id == ^conversation.id, order_by: [asc: m.id]
    )
  end
end
