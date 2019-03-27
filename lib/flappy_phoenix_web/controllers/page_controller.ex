defmodule FlappyPhoenixWeb.PageController do
  use FlappyPhoenixWeb, :controller

  def game(conn, _params) do
    Phoenix.LiveView.Controller.live_render(
      conn,
      FlappyPhoenixWeb.GameLive,
      session: %{cookies: conn.cookies}
    )
  end
end
