defmodule FlappyPhoenixWeb.PageControllerTest do
  use FlappyPhoenixWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Flappy Phoenix"
  end
end
