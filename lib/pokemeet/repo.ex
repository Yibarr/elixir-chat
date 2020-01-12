defmodule Pokemeet.Repo do
  use Ecto.Repo,
    otp_app: :pokemeet,
    adapter: Ecto.Adapters.Postgres
end
