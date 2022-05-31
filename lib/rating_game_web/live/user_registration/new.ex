defmodule RatingGameWeb.UserRegistrationLive.New do
  use Phoenix.LiveView

  alias RatingGameWeb.Router.Helpers, as: Routes
  alias RatingGame.Accounts
  alias RatingGame.Accounts.User

  def mount(_params, _session, socket) do
    changeset = Accounts.change_user_registration(%User{})
    {:ok, assign(socket, changeset: changeset)}
  end

  def render(assigns), do: Phoenix.View.render(RatingGameWeb.UserRegistrationView, "new.html", assigns)

  def handle_event("validate", %{"user" => person_params}, socket) do
    changeset =
      %User{}
      |> RatingGame.Accounts.change_user_registration(person_params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"user" => user}, socket) do
    case Accounts.register_user(user) do
      {:ok, person} ->
        {:ok, _} =
          Accounts.deliver_user_confirmation_instructions(
            person,
            &Routes.user_confirmation_url(socket, :confirm, &1)
          )

        {:noreply,
          socket
          |> put_flash(:info, "Account created successfully. Please check your email for confirmation instructions.")
          |> redirect(to: Routes.user_session_path(socket, :new))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
