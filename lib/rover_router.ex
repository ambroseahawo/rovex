defmodule Rover.Web.Router do
  use Plug.Router

  plug(Plug.Parsers, parsers: [:json], json_decoder: Jason)
  plug(:match)
  plug(:dispatch)

  get "/ping" do
    send_resp(conn, 200, Jason.encode!(%{message: "pong"}))
  end

  post "/rover" do
    rover_name = conn.body_params["name"]
    x = conn.body_params["x"]
    y = conn.body_params["y"]
    # Ensure that the direction is a valid atom
    d = convert_direction(conn.body_params["d"], conn)

    case RoverSupervisor.create_rover(rover_name, x, y, d) do
      {:ok, _} -> send_resp(conn, 201, Jason.encode!(%{message: "created rover #{rover_name}"}))
      {:error, {:already_started, _}} -> send_resp(conn, 400, Jason.encode!(%{message: "rover already exists"}))
      _ -> send_resp(conn, 500, Jason.encode!(%{message: "generic error"}))
    end
  end

  match(_) do
    send_resp(conn, 404, "")
  end

  defp convert_direction(d_str, conn) do
    case String.upcase(d_str) do
      "N" -> String.to_atom(d_str |> String.upcase())
      "S" -> String.to_atom(d_str |> String.upcase())
      "E" -> String.to_atom(d_str |> String.upcase())
      "W" -> String.to_atom(d_str |> String.upcase())
      _ -> send_resp(conn, 400, Jason.encode!(%{message: "invalid direction"}))
      halt(conn)
    end
  end
end
