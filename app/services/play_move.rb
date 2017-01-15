class PlayMove
  def call(game, point)
    if game.has_mine_on? point
      game.over!
    else
      reveal_points(game, point)
    end
  end

  private

  def reveal_points(game, point)
    return if game.is_revealed_on?(point)
    return if game.has_warning_on?(point)
    return if invalid_point?(point)

    if game.has_subyacent_mines_on?(point)
      game.mark_point_as_warning!(point) unless game.has_warning_on?(point)
    elsif !game.is_revealed_on?(point)
      game.mark_point_as_revealed!(point)
      game.subyacents(point).each do |p|
        reveal_points(game, p)
      end
    end
  end

  def invalid_point?(point)
    x = Settings.game_width
    y = Settings.game_height

    return true if point["x"] < 1 || point["y"] < 1
    return true if point["x"] > x || point["y"] > y

    false
  end

end