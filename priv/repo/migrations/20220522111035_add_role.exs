defmodule RatingGame.Repo.Migrations.AddRole do
  use Ecto.Migration
  alias RatingGame.Accounts.UserRole
  def change do
    UserRole.create_type()
    alter table("users") do
      add :role, :user_role
    end
  end
end
