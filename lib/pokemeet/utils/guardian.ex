defmodule Pokemeet.Guardian do
  use Guardian, otp_app: :Pokemeet

  alias Pokemeet.User

  def subject_for_token(resource, _claims) do
    {:ok, to_string(resource.id)}
  end

  def resource_from_claims(claims) do
    {:ok, User.find(claims["sub"])}
  end
end
