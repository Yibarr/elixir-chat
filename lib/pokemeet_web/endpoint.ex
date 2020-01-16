defmodule PokemeetWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :pokemeet
  use Absinthe.Phoenix.Endpoint
  use NewRelic.Transaction

  origin =
  case Mix.env() do
    :prod -> ["https://"]
    _ -> false
  end


  socket "/socket", Pokemeet.AbsintheSocket,
    websocket: [check_origin: origin],
    longpoll: false

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()


  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.

  # Set :encryption_salt if you would also like to encrypt it.
  # plug Plug.Session,
  #   store: :cookie,
  #   key: "_pokemeet_key",
  #   signing_salt: "3RFAatkR"

  plug CORSPlug

  plug PokemeetWeb.Router
end
