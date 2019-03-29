defmodule FlappyPhoenixWeb.GameLive do
  use Phoenix.LiveView
  alias FlappyPhoenix.Game

  def render(assigns) do
    FlappyPhoenixWeb.GameView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    socket = assign(socket, game: Game.new())

    if connected?(socket) do
      {:ok, schedule_tick(socket)}
    else
      {:ok, socket}
    end
  end

  defp schedule_tick(socket) do
    Process.send_after(self(), :tick, 50)
    socket
  end

  def handle_info(:tick, socket) do
    game = Game.update(socket.assigns.game)

    case game.state do
      :ok ->
        socket = schedule_tick(socket)
        {:noreply, assign(socket, game: game)}

      :end ->
        {:noreply, assign(socket, game: game)}
    end
  end

  def handle_event("keydown", _key, socket) do
    game = Game.flap(socket.assigns.game)
    {:noreply, assign(socket, game: game)}
  end
end
