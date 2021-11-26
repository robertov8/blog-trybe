defmodule Blog.Repo.Migrations.CreatePostTable do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add(:title, :string)
      add(:content, :string)
      add(:image, :string)
      add(:published, :utc_datetime)
      add(:user_id, references(:users, type: :binary_id))

      timestamps()
    end
  end
end
