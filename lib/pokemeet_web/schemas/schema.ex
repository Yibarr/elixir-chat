defmodule Pokemeet.Schema do
  use Absinthe.Schema

  alias Pokemeet.Data

  import_types(Absinthe.Type.Custom)
  import_types(Pokemeet.Schema.ConversationTypes)
  import_types(Pokemeet.Schema.MessageTypes)
  import_types(Pokemeet.Schema.UserTypes)

  query do
    import_fields(:conversation_queries)
    import_fields(:message_queries)
    import_fields(:user_queries)
  end

  mutation do
    import_fields(:conversation_mutations)
    import_fields(:message_mutations)
    import_fields(:user_mutations)
  end

  subscription do
    import_fields(:conversation_subscriptions)
    import_fields(:message_subscriptions)
  end

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Data, Data.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  def middleware(middleware, _field, _object) do
    [NewRelic.Absinthe.Middleware] ++ middleware
  end
end
