defmodule RoverSupervisor do
  use DynamicSupervisor

  def init(_) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_link(_) do
    DynamicSupervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def create_rover(name, x, y, direction) do
    DynamicSupervisor.start_child(__MODULE__, {Rover, {x, y, direction, name}})
  end

  def kill(rover) do
    pid = RegistryHelper.get_pid(rover.name)

    if pid != :undefined do
      DynamicSupervisor.terminate_child(__MODULE__, pid)
    else
      {:error, "Rover not found"}
    end
  end
end
