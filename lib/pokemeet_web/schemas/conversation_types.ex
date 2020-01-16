defmodule Pokemeet.Schema.ConversationTypes do
  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers, only: [dataloader: 1, dataloader: 3]

  alias Pokemeet.Service.ConversationService
  alias Pokemeet.{Data, Resolvers, Conversation}

  object :conversation do
    field :id, :id
    field :title, :string
    field :updated_at, :naive_datetime

    field :messages, list_of(:message),
      resolve: dataloader(Data, :messages, args: %{order_by: :id})

    field :users, list_of(:user), resolve: dataloader(Data)
  end

  object :conversation_queries do
    field :conversations, list_of(:conversation) do
      resolve(&Resolvers.ConversationResolver.list/3)
    end

    field :conversation, :conversation do
      arg(:id, non_null(:id))

      resolve(&Resolvers.ConversationResolver.show/3)
    end
  end

  object :conversation_mutations do
    field :create_conversation, :conversation do
      arg(:user_ids, non_null(list_of(:id)))

      resolve(&Resolvers.ConversationResolver.create/3)
    end
  end

  object :conversation_subscriptions do
    field :conversation_created, :conversation do
      config(fn _, %{context: context} ->
        case context[:current_user] do
          nil -> {:error, "unauthorized"}
          user -> {:ok, topic: user.id}
        end
      end)

      trigger(:create_conversation,
        topic: fn conversation ->
          ConversationService.user_ids(conversation)
        end
      )
    end

    field :conversation_updated, :conversation do
      config(fn _, %{context: context} ->
        case context[:current_user] do
          nil -> {:error, "Unauthorized"}
          user -> {:ok, topic: user.id}
        end
      end)

      trigger(:create_message,
        topic: fn message ->
          ConversationService.user_ids(message.conversation_id)
        end
      )

      resolve(fn message, _, _ ->
        {:ok, Conversation.find(message.conversation_id)}
      end)
    end
  end
end
