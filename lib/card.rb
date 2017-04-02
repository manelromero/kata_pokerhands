class Card
  include Comparable
  attr_reader :suit
  CARD_NAMES = { '1' => 'One', '2' => 'Two', '3' => 'Three', '4' => 'Four',
                 '5' => 'Five', '6' => 'Six', '7' => 'Seven', '8' => 'Eight',
                 '9' => 'Nine', 'T' => 'Ten', 'J' => 'Jack', 'Q' => 'Queen',
                 'K' => 'King', 'A' => 'Ace' }.freeze
  CARD_VALUES = { 'T' => 10, 'J' => 11, 'Q' => 12, 'K' => 13, 'A' => 14 }.freeze

  def initialize(code)
    @index = code[0]
    @suit = code[1]
  end

  def value
    return CARD_VALUES[@index] if letter?
    @index.to_i
  end

  def name
    CARD_NAMES[@index]
  end

  private

  def letter?
    @index.to_i.zero?
  end

  def <=>(other)
    value <=> other.value
  end
end
