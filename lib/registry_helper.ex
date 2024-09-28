defmodule RegistryHelper do
  @moduledoc """
  registry helper module doc
  """
  @doc """
  create key func
  """
  @spec create_key(String.t()) :: atom()
  def create_key(name), do: String.to_atom(name)

  def get_pid(name) do
    case Registry.lookup(RoverRegistry, name) do
      [{pid, _}] -> pid
      [] -> :undefined
    end
  end
end
