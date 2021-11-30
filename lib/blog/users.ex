defmodule Blog.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias Blog.Repo
  alias Blog.{Error, Users.User}

  @spec list_users :: nil | [User.t()] | User.t()
  @doc """
  Returns the list of users.
  """
  def list_users do
    Repo.all(User)
  end

  @spec get_user_by_uuid(uuid :: binary()) :: {:ok, [User.t()] | User.t()}
  @doc """
  Gets a single user.
  """
  def get_user_by_uuid(uuid) do
    with {:ok, %User{} = user} <- get_user_by(%{id: uuid}) do
      {:ok, user}
    end
  end

  @spec get_user_by(params :: map()) :: {:ok, User.t()} | {:error, Error.t()}
  def get_user_by(params) do
    case Repo.get_by(User, params) do
      nil -> {:error, Error.build(:not_found, "Usuário não existe")}
      user -> {:ok, user}
    end
  end

  @spec create_user(attrs :: map() | nil) :: {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  @doc """
  Creates a user.
  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @spec delete_user(user :: User.t()) :: {:ok, User.t()} | {:error, Error.t()}
  @doc """
  Deletes a user.
  """
  def delete_user(%User{} = user) do
    case Repo.delete(user, stale_error_field: true) do
      {:ok, user} -> {:ok, user}
      {:error, _changeset} -> {:error, Error.build(:not_found, "Usuário não existe")}
    end
  end

  @spec payload_login(attrs :: map() | nil) ::
          {:ok, Ecto.Schema.t()} | {:error, Ecto.Schema.t()}
  def payload_login(attrs \\ %{}) do
    User.changeset_login(%User{}, attrs)
  end
end
