defmodule RatingGame.Repo do
  use Ecto.Repo,
    otp_app: :rating_game,
    adapter: Ecto.Adapters.Postgres
end
