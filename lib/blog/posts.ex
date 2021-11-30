defmodule Blog.Posts do
  @moduledoc """
  The Posts context.
  """

  import Ecto.Query, warn: false
  alias Blog.Repo

  alias Blog.{Error, Posts.Post, Users.User}

  @spec list_posts :: nil | [Post.t()] | Post.t()
  @doc """
  Returns the list of posts.
  """
  def list_posts do
    Post
    |> Repo.all()
    |> Repo.preload(:user)
  end

  @spec list_posts_by_term(term :: binary()) :: nil | [Post.t()] | Post.t()
  def list_posts_by_term(term \\ "") do
    from(q in Post, where: like(q.title, ^"%#{term}%") or like(q.content, ^"%#{term}%"))
    |> Repo.all()
    |> Repo.preload(:user)
  end

  @spec get_post_by_uuid(uuid :: binary()) :: {:ok, [Post.t()] | Post.t()}
  @doc """
  Gets a single post.
  """
  def get_post_by_uuid(uuid) do
    case get_post_by(%{id: uuid}) do
      {:ok, %Post{} = post} -> {:ok, post}
      error -> error
    end
  end

  @spec get_post_by_user(Blog.Users.User.t(), any) ::
          {:ok, [Post.t()] | Post.t()}
          | {:error, Error.t()}
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

  @spec get_post_by(params :: map()) :: {:ok, nil | [Post.t()] | Post.t()} | {:error, Error.t()}
  def get_post_by(params) do
    case Repo.get_by(Post, params) do
      nil -> {:error, Error.build(:not_found, "Post não existe")}
      post -> {:ok, Repo.preload(post, :user)}
    end
  end

  @spec create_post(user :: User.t(), attrs :: map() | nil) ::
          {:ok, nil | [Post.t()] | Post.t()} | {:error, Ecto.Changeset.t()}
  @doc """
  Creates a post.
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

  @spec update_post(post :: Post.t(), attrs :: map()) ::
          {:ok, nil | Post.t()} | {:error, Ecto.Changeset.t()}
  @doc """
  Updates a post.
  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @spec delete_post(post :: Post.t()) :: {:error, Error.t()} | {:ok, Post.t()}
  @doc """
  Deletes a post.
  """
  def delete_post(%Post{} = post) do
    case Repo.delete(post, stale_error_field: true) do
      {:ok, post} -> {:ok, post}
      {:error, _changeset} -> {:error, Error.build(:not_found, "Post não existe")}
    end
  end

  @spec change_post(post :: Post.t(), attrs :: map()) :: Ecto.Changeset.t()
  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.
  """
  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end

  defp posts_user_query(query, %User{id: user_id}) do
    from(q in query, where: q.user_id == ^user_id)
  end
end
