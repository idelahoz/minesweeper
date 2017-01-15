require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  render_views
  describe '#create' do
    it "should return the new game" do
      post :create, format: :json
      game = json.game
      expect(game.id).to be_present
      expect(game.over).to eq false
      expect(game.warnings).to eq []
      expect(game.mines).to be_nil
    end
  end

  describe '#move' do
    it "shold return game as over if a mine is marked and return all mines" do
      post :create, format: :json
      mine = Game.last.mines.last
      post :move, point: mine, format: :json
      expect(json.game.over).to eq true
      expect(json.game.mines.size).to eq 7
    end

    it "should return game with revealed and warnings" do
      post :create, format: :json
      mines = [{"x" => 1, "y" => 1}, {"x" => 3, "y" => 4}, {"x" => 5, "y" => 2}]
      Game.last.update_attribute :mines, mines

      post :move, point: {"x" => 3, "y" => 6}, format: :json
      game = json.game

      expect(game).not_to be_over
      expect(game.mines).to be_nil
      expect(game.revealed).to eq([{"x"=>3, "y"=>6},
        {"x"=>2, "y"=>6},
        {"x"=>1, "y"=>5},
        {"x"=>1, "y"=>4},
        {"x"=>1, "y"=>3},
        {"x"=>1, "y"=>6},
        {"x"=>1, "y"=>7},
        {"x"=>2, "y"=>7},
        {"x"=>3, "y"=>7},
        {"x"=>4, "y"=>6},
        {"x"=>5, "y"=>5},
        {"x"=>5, "y"=>4},
        {"x"=>6, "y"=>4},
        {"x"=>7, "y"=>3},
        {"x"=>7, "y"=>2},
        {"x"=>7, "y"=>1},
        {"x"=>7, "y"=>4},
        {"x"=>6, "y"=>5},
        {"x"=>7, "y"=>5},
        {"x"=>6, "y"=>6},
        {"x"=>5, "y"=>6},
        {"x"=>4, "y"=>7},
        {"x"=>5, "y"=>7},
        {"x"=>6, "y"=>7},
        {"x"=>7, "y"=>6},
        {"x"=>7, "y"=>7}])

      expect(game.warnings).to match_array([{"x"=>2, "y"=>5, "number"=>1},
         {"x"=>3, "y"=>5, "number"=>1},
         {"x"=>4, "y"=>5, "number"=>1},
         {"x"=>1, "y"=>2, "number"=>1},
         {"x"=>2, "y"=>2, "number"=>1},
         {"x"=>2, "y"=>3, "number"=>1},
         {"x"=>2, "y"=>4, "number"=>1},
         {"x"=>4, "y"=>4, "number"=>1},
         {"x"=>4, "y"=>3, "number"=>2},
         {"x"=>5, "y"=>3, "number"=>1},
         {"x"=>6, "y"=>3, "number"=>1},
         {"x"=>6, "y"=>2, "number"=>1},
         {"x"=>6, "y"=>1, "number"=>1}])
    end
  end
end
