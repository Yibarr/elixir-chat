defmodule Pokemeet.Schema.UserTypes do
  use Absinthe.Schema.Notation

  alias Pokemeet.{Resolvers}

  object :user do
    field :id, :id
    field :name, :string
    field :email, :string
    field :token, :string
  end

  object :user_queries do
    field :search_users, list_of(:user) do
      arg(:search_term, non_null(:string))
    end
  end

  object :user_mutations do
    field :authenticate, :user do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&Resolvers.UserResolver.authenticate/3)
    end

    field :sign_up, :user do
      arg(:name, non_null(:string))
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&Resolvers.UserResolver.signup/3)
    end
  end
end
