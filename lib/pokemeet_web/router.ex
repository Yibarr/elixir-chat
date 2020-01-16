defmodule PokemeetWeb.Router do
  use Phoenix.Router

  pipeline :api do
    plug Pokemeet.Context
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL, schema: Pokemeet.Schema

    forward "/", Absinthe.Plug, schema: Pokemeet.Schema
  end
end
