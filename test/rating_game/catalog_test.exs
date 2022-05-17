defmodule RatingGame.CatalogTest do
  use RatingGame.DataCase

  alias RatingGame.Catalog

  describe "games" do
    alias RatingGame.Catalog.Game

    import RatingGame.CatalogFixtures

    @invalid_attrs %{game_name: nil}

    test "list_games/0 returns all games" do
      game = game_fixture()
      assert Catalog.list_games() == [game]
    end

    test "get_game!/1 returns the game with given id" do
      game = game_fixture()
      assert Catalog.get_game!(game.id) == game
    end

    test "create_game/1 with valid data creates a game" do
      valid_attrs = %{game_name: "some game_name"}

      assert {:ok, %Game{} = game} = Catalog.create_game(valid_attrs)
      assert game.game_name == "some game_name"
    end

    test "create_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalog.create_game(@invalid_attrs)
    end

    test "update_game/2 with valid data updates the game" do
      game = game_fixture()
      update_attrs = %{game_name: "some updated game_name"}

      assert {:ok, %Game{} = game} = Catalog.update_game(game, update_attrs)
      assert game.game_name == "some updated game_name"
    end

    test "update_game/2 with invalid data returns error changeset" do
      game = game_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.update_game(game, @invalid_attrs)
      assert game == Catalog.get_game!(game.id)
    end

    test "delete_game/1 deletes the game" do
      game = game_fixture()
      assert {:ok, %Game{}} = Catalog.delete_game(game)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_game!(game.id) end
    end

    test "change_game/1 returns a game changeset" do
      game = game_fixture()
      assert %Ecto.Changeset{} = Catalog.change_game(game)
    end
  end
end
