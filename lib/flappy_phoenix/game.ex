defmodule FlappyPhoenix.Game do
  alias __MODULE__
  defstruct [:bird, :score, :state]

  def new() do
    %Game{
      state: :ok,
      bird: %{position: 50, wings: 0, flap: false},
      score: 0.0
    }
  end

  def advance(game) do
    bird = %{game.bird | position: min(game.bird.position + 4, 75)}
    bird = %{bird | wings: rem(bird.wings + 1, 3), flap: false}
    %{game | score: game.score + 0.1, bird: bird, state: state(game)}
  end

  def flap(game) do
    bird = %{game.bird | position: max(game.bird.position - 12, 0), flap: true}
    %{game | bird: bird}
  end

  defp state(game) do
    case game.bird.position do
      x when x > 74 -> :end
      x when x < 1 -> :end
      _ -> :ok
    end
  end
end
