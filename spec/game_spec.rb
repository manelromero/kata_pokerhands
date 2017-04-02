require 'game'

describe Game do
  it 'returns the final result' do
    game = Game.new({ player: 'Black', cards: %w(KC 7D KH AS KD) },
                    { player: 'White', cards: %w(4C 5D 6H 5S 3H) })

    expect(game.result).to eq('Black wins with King-high three of a kind')
  end
end
