class GamesController < ApplicationController
  before_filter :load_game, only: :move

  def create
    @game = Game.create
    BuildGame.new.call(@game)
  end

  def move
    PlayMove.new.call(@game, params[:point])
  end

  private

  def load_game
    @game = Game.last
  end
end
