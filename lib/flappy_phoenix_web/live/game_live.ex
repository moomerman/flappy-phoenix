defmodule FlappyPhoenixWeb.GameLive do
  use Phoenix.LiveView
  alias FlappyPhoenix.Game

  def render(assigns) do
    FlappyPhoenixWeb.GameView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, new_game(socket)}
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
    game = socket.assigns.game

    case game.state do
      :ok -> {:noreply, assign(socket, game: Game.flap(game))}
      _ -> {:noreply, new_game(socket)}
    end
  end

  defp new_game(socket) do
    socket
    |> assign(game: Game.new())
    |> schedule_tick
  end

  defp schedule_tick(socket) do
    if connected?(socket) do
      Process.send_after(self(), :tick, 50)
    end

    socket
  end
end
