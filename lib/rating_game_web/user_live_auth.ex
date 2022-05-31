defmodule RatingGameWeb.UserLiveAuth do
  import Phoenix.LiveView
  alias RatingGame.Accounts

  def on_mount(:default, _params, %{"user_token" => user_token} = _session, socket) do
    IO.inspect("hereee")
    socket = assign_new(socket, :current_user, fn ->
      Accounts.get_user_by_session_token(user_token)
    end)

    if socket.assigns.current_user.role in [:user, :admin, :super_admin] do
      {:cont, socket}
    else
      {:halt, redirect(socket, to: "/users/login")}
    end
  end

  def on_mount(:super_admin, _params, %{"user_token" => user_token} = _session, socket) do
    socket = assign_new(socket, :current_user, fn ->
      Accounts.get_user_by_session_token(user_token)
    end)

    if socket.assigns.current_user.role==:super_admin do
      {:cont, socket}
    else
      socket =
        socket
        |> put_flash(:info, "You don't have Rights to Access this page")

      {:halt, redirect(socket, to: "/")}
    end
  end

  def on_mount(:admin, _params, %{"user_token" => user_token} = _session, socket) do
    socket = assign_new(socket, :current_user, fn ->
      Accounts.get_user_by_session_token(user_token)
    end)

    if socket.assigns.current_user.role==:admin do

      {:cont, socket}
    else
      socket =
        socket
        |> put_flash(:info, "You don't have Rights to Access this page")
      {:halt, redirect(socket, to: "/")}
    end
  end



end
