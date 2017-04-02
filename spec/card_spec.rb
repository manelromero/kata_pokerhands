require 'card'

describe Card do
  it 'returns two to nine card values' do
    two = Card.new('2H')
    seven = Card.new('7S')

    expect(two.value).to eq(2)
    expect(seven.value).to eq(7)
  end

  it 'returns ten to ace card values ' do
    queen = Card.new('QH')
    ace = Card.new('AS')

    expect(queen.value).to eq(12)
    expect(ace.value).to eq(14)
  end

  it 'returns the card suit' do
    card = Card.new('AS')

    expect(card.suit).to eq('S')
  end

  it 'returns the card name' do
    five = Card.new('5H')
    jack = Card.new('JS')

    expect(five.name).to eq('Five')
    expect(jack.name).to eq('Jack')
  end

  it 'compares card values' do
    queen = Card.new('QS')
    eight = Card.new('8H')

    expect(queen > eight).to be true
  end
end
