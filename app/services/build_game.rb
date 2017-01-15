class BuildGame
  def call(game)
    x = Settings.game_width
    y = Settings.game_height

    game.mines = make_mines(x, y)
    game.save
  end

  private

  def make_mines(x, y)
    mines = []
    x.times do
      mines << generate_point(mines, x, y)
    end
    mines
  end

  def exists?(mines, point)
    mines.select {|p| p["x"] == point["x"] && p["y"] == point["y"] }.any?
  end

  def generate_point(mines, x, y)
    point = {"x" => Random.rand(x), "y" => Random.rand(y)}
    exists?(mines, point) ? generate_point(mines, x, y) : point
  end
end