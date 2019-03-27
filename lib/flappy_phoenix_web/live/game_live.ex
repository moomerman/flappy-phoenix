defmodule FlappyPhoenixWeb.GameLive do
  use Phoenix.LiveView

  def render(assigns) do
    FlappyPhoenixWeb.GameView.render("index.html", assigns)
  end

  def mount(session, socket) do
    socket =
      socket
      |> new_game()

    if connected?(socket) do
      {:ok, schedule_tick(socket)}
    else
      {:ok, socket}
    end
  end

  defp new_game(socket) do
    assign(socket, %{})
  end

  defp schedule_tick(socket) do
    Process.send_after(self(), :tick, 500)
    socket
  end

  def handle_info(:tick, socket) do
    IO.inspect("tick")
    {:noreply, schedule_tick(socket)}
  end
end
