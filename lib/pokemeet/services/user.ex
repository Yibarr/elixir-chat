defmodule Pokemeet.Service.UserService do
  import Ecto.Query
  alias Pokemeet.{User, Repo}

  def search(search_term, current_user) do
    Repo.all(
      from u in User,
        where: ilike(u.name, ^("%" <> search_term <> "%")) and u.id != ^current_user.id,
        limit: 25
    )
  end
end
