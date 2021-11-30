defmodule Blog.Error do
  @keys [:status, :message]

  @enforce_keys @keys

  defstruct @keys

  @type t :: %__MODULE__{message: atom(), status: binary()}

  @spec build(status :: atom(), message :: binary()) :: t()
  def build(status, message) do
    %__MODULE__{
      status: status,
      message: message
    }
  end
end
