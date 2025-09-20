defmodule MingleMe.Repo.Migrations.RemoveUser do
  use Ecto.Migration

  def change do
    drop table("users")
  end
end
