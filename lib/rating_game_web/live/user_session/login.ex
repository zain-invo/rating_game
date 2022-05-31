defmodule RatingGameWeb.UserSessionLive.Login do
  use Phoenix.LiveView

  alias RatingGame.{Accounts, Accounts.User}

  def mount(_params, _session, socket) do
    changeset = User.login_changeset(%User{}, %{})

    socket =
      socket
      |> assign(changeset: changeset)
      |> assign(error_message: false)
      |> assign(:trigger_submit, false)

    {:ok, socket}
  end

  def render(assigns), do: Phoenix.View.render(RatingGameWeb.UserSessionView, "form.html", assigns)

  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset =
      %User{}
      |> User.login_changeset(user_params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    %{"email" => email, "password" => password, "remember_me" => _remember_me} = user_params
    changeset = User.login_changeset(%User{}, user_params)

    case Accounts.get_user_by_email_and_password(email, password) do
      nil ->
        socket =
          socket
          |> assign(changeset: changeset |> Map.put(:action, :insert))
          |> assign(:error_message, "Invalid email or password")

        {:noreply, socket}
      user ->
        {:noreply, assign(socket, changeset: changeset, trigger_submit: true)}
    end
  end

end
