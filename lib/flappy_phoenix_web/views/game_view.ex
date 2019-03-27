defmodule FlappyPhoenixWeb.GameView do
  use FlappyPhoenixWeb, :view

  def format_score(score) do
    score |> Float.round(1)
  end
end
