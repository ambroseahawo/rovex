defmodule Rover do
  @moduledoc """
  Documentation for `Rovex`.
  """
  use GenServer

  defstruct [:x, :y, :direction, :name]

  def init({x, y, d, name}) do
    {:ok, %Rover{x: x, y: y, direction: d, name: name}}
  end

  def get_state(name) do
    GenServer.call(String.to_atom(name), :get_state)
  end

  def start_link({x, y, d, name}) do
    GenServer.start_link(__MODULE__, {x, y, d, name}, name: String.to_atom(name))
  end

  def handle_call(:get_state, _from, state) do
    {:reply, {:ok, {state.x, state.y, state.direction, state.name}}, state}
  end
end
