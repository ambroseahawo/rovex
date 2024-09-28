defmodule Rover.Application do
  use Application

  def start(_type, _args) do
    children = [
      Supervisor.child_spec({Registry, [keys: :unique, name: Rover.Registry]},
        id: :rover_registry
      ),
      Supervisor.child_spec({RoverSupervisor, []}, id: RoverSupervisor),
      {Plug.Cowboy, scheme: :http, plug: Rover.Web.Router, options: [port: 3000]}
    ]

    opts = [strategy: :one_for_one, name: Application.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
