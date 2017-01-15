require 'rails_helper'

RSpec.describe BuildGame do
  let(:game){ create(:game) }

  describe '#call' do
    it "should generate random points" do
      BuildGame.new.call(game)
      expect(game.mines.count).to eq(Settings.game_width)
    end

    it "should generate unique points" do
      BuildGame.new.call(game)
      expect(game.mines.uniq.count).to eq(Settings.game_width)
    end
  end
end