defmodule Blog.Posts do
  @moduledoc """
  The Posts context.
  """

  import Ecto.Query, warn: false
  alias Blog.Repo

  alias Blog.{Error, Posts.Post, Users.User}
  alias Ecto.UUID

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    Post
    |> Repo.all()
    |> Repo.preload(:user)
  end

  def list_posts_by_term(term \\ "") do
    from(q in Post, where: like(q.title, ^"%#{term}%") or like(q.content, ^"%#{term}%"))
    |> Repo.all()
    |> Repo.preload(:user)
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post_by_uuid(123)
      {:ok, %Post{}}

      iex> get_post_by_uuid(456)
      ** (Ecto.NoResultsError)

  """
  def get_post_by_uuid(uuid) do
    case get_post_by(%{id: uuid}) do
      {:ok, %Post{} = post} -> {:ok, post}
      error -> error
    end
  end

  def get_post_by_user(%User{} = user, uuid) do
    query = posts_user_query(Post, user)

    with {:ok, %Post{}} <- get_post_by(%{id: uuid}),
         post when not is_nil(post) <- Repo.get(query, uuid) do
      {:ok, Repo.preload(post, :user)}
    else
      nil ->
        {:error, Error.build(:unauthorized, "Usuário não autorizado")}

      {:error, _reason} ->
        {:error, Error.build(:not_found, "Post não existe")}
    end
  end

  def get_post_by(params) do
    case Repo.get_by(Post, params) do
      nil -> {:error, Error.build(:not_found, "Post não existe")}
      post -> {:ok, Repo.preload(post, :user)}
    end
  end

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(%User{} = user, attrs \\ %{}) do
    changeset =
      %Post{}
      |> Post.changeset(attrs)
      |> Ecto.Changeset.put_assoc(:user, user)

    case Repo.insert(changeset) do
      {:ok, post} -> {:ok, Repo.preload(post, :user)}
      error -> error
    end
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Error{}}

  """
  def delete_post(%Post{} = post) do
    case Repo.delete(post, stale_error_field: true) do
      {:ok, post} -> {:ok, post}
      {:error, _changeset} -> {:error, Error.build(:not_found, "Post não existe")}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{data: %Post{}}

  """
  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end

  defp posts_user_query(query, %User{id: user_id}) do
    from(q in query, where: q.user_id == ^user_id)
  end
end
