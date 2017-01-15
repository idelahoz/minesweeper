class Game < ActiveRecord::Base
  serialize :warnings, JSON
  serialize :mines, JSON
  serialize :revealed, JSON

  def initialize(attr = {})
    super(attr)
    self.over = false
    self.warnings = []
    self.mines = []
    self.revealed = []
  end

  def has_mine_on?(point)
    self.mines.select {|p| p["x"] == point["x"] && p["y"] == point["y"]}.any?
  end

  def is_revealed_on?(point)
    self.revealed.select {|p| p["x"] == point["x"] && p["y"] == point["y"]}.any?
  end

  def has_warning_on?(point)
    self.warnings.select {|p| p["x"] == point["x"] && p["y"] == point["y"]}.any?
  end

  def has_subyacent_mines_on?(point)
    subyacents_with_mine(point).any?
  end

  def mark_point_as_warning!(point)
    self.warnings << {"x" => point["x"], "y" => point["y"], "number" => subyacents_with_mine(point).count }
    save
  end

  def mark_point_as_revealed!(point)
    self.revealed << {"x" => point["x"], "y" => point["y"]}
    save
  end

  def over!
    update_attribute :over, true
  end

  def subyacents(point)
    points = [
      {"y" => point["y"] - 1, "x" => point["x"] - 1}, 
      {"y" => point["y"] - 1, "x" => point["x"]}, 
      {"y" => point["y"] - 1, "x" => point["x"] + 1}, 
      {"y" => point["y"], "x" => point["x"] - 1}, 
      {"y" => point["y"], "x" => point["x"] + 1}, 
      {"y" => point["y"] + 1, "x" => point["x"] - 1}, 
      {"y" => point["y"] + 1, "x" => point["x"]}, 
      {"y" => point["y"] + 1, "x" => point["x"] + 1}
    ]
    points.each do |p|
      points.delete(p) if invalid_point?(p)
    end

    points
  end

  private

  def subyacents_with_mine(point)
    subyacents(point).select {|p| has_mine_on? p }
  end

  def invalid_point?(point)
    x = Settings.game_width
    y = Settings.game_height

    return true if point["x"] < 1 || point["y"] < 1
    return true if point["x"] > x || point["y"] > y

    false
  end
end
