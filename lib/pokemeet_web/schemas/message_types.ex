defmodule Pokemeet.Schema.MessageTypes do
  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers, only: [dataloader: 1]
  alias Pokemeet.Service.ConversationService
  alias Pokemeet.{Data, Resolvers}

  object :message do
    field :id, :id
    field :body, :string

    field :conversation, :conversation, resolve: dataloader(Data)
    field :user, :user, resolve: dataloader(Data)
  end

  object :message_queries do
    field :messages, list_of(:message) do
      arg(:conversation_id, non_null(:id))
      resolve(&Resolvers.MessageResolver.list/3)
    end
  end

  object :message_mutations do
    field :create_message, :message do
      arg(:conversation_id, non_null(:id))
      arg(:body, non_null(:string))

      resolve(&Resolvers.MessageResolver.create/3)
    end
  end

  object :message_subscriptions do
    field :message_created, :message do
      arg(:conversation_id, non_null(:id))

      config(fn args, %{context: context} ->
        with user when not is_nil(user) <- context[:current_user],
             conversation when not is_nil(conversation) <-
              ConversationService.find_for_user(args[:conversation_id], user) do
          {:ok, topic: conversation.id}
        else
          _ -> {:error, "Unauthorized"}
        end
      end)

      trigger(:create_message,
        topic: fn message ->
          message.conversation_id
        end
      )
    end
  end
end
