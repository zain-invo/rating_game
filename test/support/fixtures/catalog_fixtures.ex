defmodule RatingGame.CatalogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RatingGame.Catalog` context.
  """

  @doc """
  Generate a game.
  """
  def game_fixture(attrs \\ %{}) do
    {:ok, game} =
      attrs
      |> Enum.into(%{
        game_name: "some game_name"
      })
      |> RatingGame.Catalog.create_game()

    game
  end
end
