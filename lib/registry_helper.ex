defmodule RegistryHelper do
  @moduledoc """
  registry helper module doc
  """
  @doc """
  create key func
  """
  @spec create_key(String.t()) :: atom()
  def create_key(name), do: String.to_atom(name)
end
