defmodule RatingGame.SurveyFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RatingGame.Survey` context.
  """

  @doc """
  Generate a rating.
  """
  def rating_fixture(attrs \\ %{}) do
    {:ok, rating} =
      attrs
      |> Enum.into(%{
        rating: 42
      })
      |> RatingGame.Survey.create_rating()

    rating
  end
end
