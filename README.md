# Flappy Phoenix

Flappy Phoenix is a Flappy Bird clone written in Elixir using
[Phoenix LiveView](https://github.com/phoenixframework/phoenix_live_view) to
render the game UI from the server.

 ![Screenshot](screenshot.png)

Try the game on [Heroku](https://flappy-phoenix.herokuapp.com).

Some interesting files:

* [The LiveView integration](https://github.com/moomerman/flappy-phoenix/blob/master/lib/flappy_phoenix_web/live/game_live.ex)
* [The Game logic](https://github.com/moomerman/flappy-phoenix/blob/master/lib/flappy_phoenix/game.ex)
* [The UI](https://github.com/moomerman/flappy-phoenix/blob/master/lib/flappy_phoenix_web/templates/game/index.html.leex)

## Credits

The game assets were repurposed from the [Motion Game](https://github.com/HipByte/motion-game) sample app.

## Running it locally

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
