defmodule RatingGameWeb.PageController do
  use RatingGameWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
