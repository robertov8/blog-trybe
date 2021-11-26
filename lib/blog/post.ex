defmodule Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias Blog.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params ~w(title content user_id)a
  @optional_params ~w(image)a

  schema "posts" do
    field(:title, :string)
    field(:content, :string)
    field(:image, :string)
    field(:published, :utc_datetime)

    belongs_to(:user, User)

    timestamps()
  end

  def changeset(post, attrs) do
    post
    |> cast(attrs, @required_params ++ @optional_params)
    |> validate_required(@required_params)
  end
end
