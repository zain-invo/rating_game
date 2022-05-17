defmodule RatingGame.Survey.Rating do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ratings" do
    field :rating, :integer

    belongs_to :user, RatingGame.Accounts.User
    belongs_to :game, RatingGame.Catalog.Game

    timestamps()
  end

  @doc false
  def changeset(rating, attrs) do
    rating
    |> cast(attrs, [:rating, :user_id, :game_id])
    |> validate_required([:rating, :user_id, :game_id])
  end
end
