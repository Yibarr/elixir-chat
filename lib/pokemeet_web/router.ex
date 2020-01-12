defmodule PokemeetWeb.Router do
  use PokemeetWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PokemeetWeb do
    pipe_through :api
  end
end
