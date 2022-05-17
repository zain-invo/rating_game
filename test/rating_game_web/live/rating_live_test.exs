defmodule RatingGameWeb.RatingLiveTest do
  use RatingGameWeb.ConnCase

  import Phoenix.LiveViewTest
  import RatingGame.SurveyFixtures

  @create_attrs %{rating: 42}
  @update_attrs %{rating: 43}
  @invalid_attrs %{rating: nil}

  defp create_rating(_) do
    rating = rating_fixture()
    %{rating: rating}
  end

  describe "Index" do
    setup [:create_rating]

    test "lists all ratings", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.rating_index_path(conn, :index))

      assert html =~ "Listing Ratings"
    end

    test "saves new rating", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.rating_index_path(conn, :index))

      assert index_live |> element("a", "New Rating") |> render_click() =~
               "New Rating"

      assert_patch(index_live, Routes.rating_index_path(conn, :new))

      assert index_live
             |> form("#rating-form", rating: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#rating-form", rating: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.rating_index_path(conn, :index))

      assert html =~ "Rating created successfully"
    end

    test "updates rating in listing", %{conn: conn, rating: rating} do
      {:ok, index_live, _html} = live(conn, Routes.rating_index_path(conn, :index))

      assert index_live |> element("#rating-#{rating.id} a", "Edit") |> render_click() =~
               "Edit Rating"

      assert_patch(index_live, Routes.rating_index_path(conn, :edit, rating))

      assert index_live
             |> form("#rating-form", rating: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#rating-form", rating: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.rating_index_path(conn, :index))

      assert html =~ "Rating updated successfully"
    end

    test "deletes rating in listing", %{conn: conn, rating: rating} do
      {:ok, index_live, _html} = live(conn, Routes.rating_index_path(conn, :index))

      assert index_live |> element("#rating-#{rating.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#rating-#{rating.id}")
    end
  end

  describe "Show" do
    setup [:create_rating]

    test "displays rating", %{conn: conn, rating: rating} do
      {:ok, _show_live, html} = live(conn, Routes.rating_show_path(conn, :show, rating))

      assert html =~ "Show Rating"
    end

    test "updates rating within modal", %{conn: conn, rating: rating} do
      {:ok, show_live, _html} = live(conn, Routes.rating_show_path(conn, :show, rating))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Rating"

      assert_patch(show_live, Routes.rating_show_path(conn, :edit, rating))

      assert show_live
             |> form("#rating-form", rating: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#rating-form", rating: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.rating_show_path(conn, :show, rating))

      assert html =~ "Rating updated successfully"
    end
  end
end
