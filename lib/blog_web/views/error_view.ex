defmodule BlogWeb.ErrorView do
  use BlogWeb, :view

  import Ecto.Changeset, only: [traverse_errors: 2]

  alias Blog.Error
  alias Ecto.Changeset

  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end

  def render("error.json", %{result: %Changeset{} = changeset, show_field: show_field}) do
    %{message: translate_errors(changeset, show_field)}
  end

  def render("error.json", %{result: %Changeset{} = changeset}) do
    %{message: translate_errors(changeset)}
  end

  def render("error.json", %{result: %Error{message: message}}) do
    %{message: message}
  end

  def render("error.json", %{result: result}) do
    %{message: result}
  end

  defp translate_errors(changeset, show_field \\ true) do
    changeset
    |> traverse_errors(fn {msg, _opts} -> msg end)
    |> Map.to_list()
    |> Enum.reduce([], &translate_value(&1, &2, show_field))
  end

  defp translate_value({field, [error | _]}, _acc, show_field) do
    if show_field do
      ~s("#{field}" #{error})
    else
      "#{error}"
    end
  end
end
