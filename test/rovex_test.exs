defmodule RoverTest do
  use ExUnit.Case
  doctest Rover

  test "get_state should return current state" do
    {:ok, _} = Rover.start_link({9, 9, :N, "rover0"})
    {:ok, state} = Rover.get_state("rover0")
    assert state == {9, 9, :N, "rover0"}
  end

  test "handle_cast :go_forward should return updated state" do
    {:noreply, state} = Rover.handle_cast(:go_forward, %Rover{x: 1, y: 3, direction: :N})
    assert state.x == 1
    assert state.y == 4
    assert state.direction == :N
  end
end
