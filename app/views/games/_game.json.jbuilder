json.game do
  json.call(game, :id, :over)
  json.warnings game.warnings
  json.revealed game.revealed

  if game.over
    json.mines game.mines
  end
end