class GamesController < ApplicationController
  before_filter :load_game, only: :move

  def create
    @game = Game.create
    BuildGame.new.call(@game)
  end

  def move
    PlayMove.new.call(@game, point_from_params)
  end

  private

  def load_game
    @game = Game.last
  end

  def point_from_params
    {"x" => params[:point]["x"].to_i, "y" => params[:point]["y"].to_i }
  end
end
