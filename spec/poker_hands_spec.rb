require 'poker_hands'

describe Card do
  it 'shows two to nine card values' do
    card = Card.new('2H')
    expect(card.value).to eq(2)
  end

  it 'shows ten to ace card values ' do
    queen = Card.new('QH')
    ace = Card.new('AS')
    expect(queen.value).to eq(12)
    expect(ace.value).to eq(14)
  end

  it 'shows the card suit' do
    card = Card.new('AS')
    expect(card.suit).to eq('S')
  end

  it 'shows the card name' do
    five_card = Card.new('5H')
    jack_card = Card.new('JS')
    expect(five_card.name).to eq('Five')
    expect(jack_card.name).to eq('Jack')
  end

  it 'compares card values' do
    queen = Card.new('QS')
    eight = Card.new('8H')
    expect(queen > eight).to be true
  end
end

describe PokerHand do
  it 'identifies the player name' do
    hand = PokerHand.new(player: 'Black', cards: %w(2H 3D 5S TC KD))
    expect(hand.player).to eq('Black')
  end

  it 'identifies the cards' do
    hand = PokerHand.new(player: 'Black', cards: %w(2H 3D 5S TC KD))
    hand.cards.each do |card|
      expect(card).to be_a Card
    end
  end

  it 'returns points' do
    hand = PokerHand.new(player: 'Black', cards: %w(JH TH QH 9H 8H))
    expect(hand.points).to eq(9)
  end

  it 'returns straight flush' do
    hand = PokerHand.new(player: 'Black', cards: %w(JH TH QH 9H 8H))
    expect(hand.rate).to eq('straight flush')
    expect(hand.high_card.name).to eq('Queen')
  end

  xit 'returns straight flush starting with Ace' do
    hand = PokerHand.new(player: 'Black', cards: %w(4H AH 3H 5H 2H))
    expect(hand.rate).to eq('straight flush')
    expect(hand.high_card.name).to eq('Five')
  end

  it 'returns four of a kind' do
    hand = PokerHand.new(player: 'Black', cards: %w(KC KD KH KS AH))
    expect(hand.rate).to eq('four of a kind')
    expect(hand.high_card.name).to eq('King')
  end

  it 'returns full house' do
    hand = PokerHand.new(player: 'Black', cards: %w(5C 5D 5H AS AH))
    expect(hand.rate).to eq('full house')
    expect(hand.high_card.name).to eq('Five')
  end

  it 'returns flush' do
    hand = PokerHand.new(player: 'Black', cards: %w(JH TH 4H 6H 2H))
    expect(hand.rate).to eq('flush')
    expect(hand.high_card.name).to eq('Jack')
  end

  it 'returns straight' do
    hand = PokerHand.new(player: 'Black', cards: %w(4C 7D 6H 8S 5H))
    expect(hand.rate).to eq('straight')
    expect(hand.high_card.name).to eq('Eight')
  end

  xit 'returns straight starting with Ace' do
    hand = PokerHand.new(player: 'Black', cards: %w(4C 3D 2H AS 5H))
    expect(hand.rate).to eq('straight')
    expect(hand.high_card.name).to eq('Five')
  end

  it 'returns three of a kind' do
    hand = PokerHand.new(player: 'Black', cards: %w(KC 7D KH AS KD))
    expect(hand.rate).to eq('three of a kind')
    expect(hand.high_card.name).to eq('King')
  end

  it 'returns two pairs' do
    hand = PokerHand.new(player: 'Black', cards: %w(4C TD 4H TS 3H))
    expect(hand.rate).to eq('two pairs')
    expect(hand.high_card.name).to eq('Ten')
  end

  it 'returns pair' do
    hand = PokerHand.new(player: 'Black', cards: %w(4C 5D 6H 5S 3H))
    expect(hand.rate).to eq('pair')
    expect(hand.high_card.name).to eq('Five')
  end

  it 'returns high card' do
    hand = PokerHand.new(player: 'Black', cards: %w(4C 7D 6H 2S 3H))
    expect(hand.rate).to eq('high card')
    expect(hand.high_card.name).to eq('Seven')
  end

  it 'compares two different hands' do
    winner_hand = PokerHand.new(cards: %w(5C 5D 5H AS AH))
    loser_hand = PokerHand.new(cards: %w(4C 5D 6H 5S 3H))
    expect(winner_hand > loser_hand).to be true
  end

  it 'compares two hands with same result but different value' do
    winner_hand = PokerHand.new(cards: %w(6C 6D 7H 8S QH))
    loser_hand = PokerHand.new(cards: %w(5H 5S 3H TC 2D))
    expect(winner_hand > loser_hand).to be true
  end

  xit 'compares two hands with same result but different high card' do
    winner_hand = PokerHand.new(cards: %w(5C 5D 2H QS TH))
    loser_hand = PokerHand.new(cards: %w(5H 5S 6H JS 3H))
    expect(winner_hand > loser_hand).to be true
  end

  it 'compares two hands with same result' do
    first_hand = PokerHand.new(cards: %w(5C 5D AH AS TH))
    second_hand = PokerHand.new(cards: %w(5H 5S AD AC TS))
    expect(first_hand == second_hand).to be true
  end
end

describe Result do
  it 'identifies hands' do
    result = Result.new([{ player: 'Black', cards: %w(2H 3D 5S 9C KD) },
                         { player: 'White', cards: %w(2C 3H 4S 8C AH) }])
    result.hands.each do |hand|
      expect(hand).to be_a PokerHand
    end
  end
end

describe Game do
  it 'returns the winner' do
    game = Game.new({ player: 'Black', cards: %w(KC 7D KH AS KD) },
                    { player: 'White', cards: %w(4C 5D 6H 5S 3H) })
    expect(game.result).to eq('Black wins with King-high three of a kind')
  end
end
