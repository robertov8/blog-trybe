defmodule Blog.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:display_name, :string)
      add(:email, :string)
      add(:password_hash, :string)
      add(:image, :string)

      timestamps()
    end

    create(unique_index(:users, [:email]))
  end
end
