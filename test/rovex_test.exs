defmodule RoverTest do
  use ExUnit.Case
  doctest Rover

  test "get_state should return current state" do
    {:ok, _} = Rover.start_link({9, 9, :N, "rover0"})
    {:ok, state} = Rover.get_state("rover0")
    assert state == {9, 9, :N, "rover0"}
  end
end
