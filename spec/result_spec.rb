require 'result'

describe Result do
  it 'identifies hands' do
    result = Result.new([{ player: 'Black', cards: %w(2H 3D 5S 9C KD) },
                         { player: 'White', cards: %w(2C 3H 4S 8C AH) }])

    result.hands.each do |hand|
      expect(hand).to be_a PokerHand
    end
  end

  it 'returns the result phrase' do
    result = Result.new([{ player: 'Black', cards: %w(2H 3D 5S 9C KD) },
                         { player: 'White', cards: %w(2C 3H 4S 8C AH) }])

    expect(result.quote).to eq('White wins with Ace-high high card')
  end
end
