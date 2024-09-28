defmodule Rover.Web.Router do
  use Plug.Router

  plug(Plug.Parsers, parsers: [:json], json_decoder: Jason)
  plug(:match)
  plug(:dispatch)

  get "/ping" do
    send_resp(conn, 200, Jason.encode!(%{message: "pong"}))
  end

  match(_) do
    send_resp(conn, 404, "")
  end
end
