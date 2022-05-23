defmodule RatingGame.Accounts.UserRole do
  use EctoEnum, type: :user_role, enums: [:super_admin, :admin, :user]
end
