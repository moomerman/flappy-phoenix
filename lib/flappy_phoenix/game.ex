defmodule FlappyPhoenix.Game do
  alias __MODULE__
  defstruct [:bird, :pipes, :score, :state, :updated]
  @gravity 1
  @tick 100_000_000

  def new() do
    %Game{
      state: :ok,
      bird: %{x: 10, y: 35, wings: 0, velocity: 0},
      pipes: [%{x: 0}],
      score: 0.0,
      updated: System.monotonic_time() - @tick
    }
  end

  def update(%{state: :ok} = game) do
    time = System.monotonic_time()
    dt = (time - game.updated) / @tick

    game
    |> move_bird
    |> move_pipes
    |> check_for_collisions
    |> Map.put(:score, game.score + 0.1 * dt)
    |> Map.put(:updated, time)
  end

  def update(game), do: game

  def flap(%{state: :ok} = game) do
    %{game | bird: %{game.bird | velocity: 3}}
  end

  def flap(game), do: game

  defp move_bird(game) do
    bird =
      game.bird
      |> Map.put(:wings, rem(game.bird.wings + 1, 4))
      |> Map.put(:velocity, game.bird.velocity - @gravity)
      |> Map.put(:y, min(game.bird.y - 1.5 * game.bird.velocity, 76))

    %{game | bird: bird}
  end

  defp move_pipes(game) do
    %{game | pipes: game.pipes |> Enum.map(fn p -> move_pipe(p) end)}
  end

  defp move_pipe(pipe) do
    %{x: pipe.x + 5}
  end

  defp check_for_collisions(game) do
    %{game | state: state(game)}
  end

  defp state(game) do
    case game.bird.y do
      x when x > 75 -> :end
      x when x < 1 -> :end
      _ -> :ok
    end
  end
end
