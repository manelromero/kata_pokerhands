class PokerHand
  include Comparable
  attr_reader :player, :cards
  POINTS = { 'straight flush' => 9, 'four of a kind' => 8, 'full house' => 7,
             'flush' => 6, 'straight' => 5, 'three of a kind' => 4,
             'two pairs' => 3, 'pair' => 2, 'high card' => 1 }.freeze

  def initialize(args)
    @player = args[:player]
    @cards = []
    args[:cards].each do |card|
      @cards << Card.new(card)
    end
  end

  def points
    POINTS[rate]
  end

  def rate
    case group_cards.length
    when 2
      return 'four of a kind' if group_of?(4)
      'full house'
    when 3
      return 'three of a kind' if group_of?(3)
      'two pairs'
    when 4
      'pair'
    when 5
      return 'straight flush' if straight? && same_suit?
      return 'flush' if same_suit?
      return 'straight' if straight?
      'high card'
    end
  end

  def high_card
    card = { 'four of a kind' => group_of(4).max,
             'full house' => group_of(3).max,
             'three of a kind' => group_of(3).max,
             'pair' => group_of(2).max }
    card[rate] || highest_card
  end

  def other_values
    values = { 'two pairs' => values(group_of(1)),
               'pair' => values(cards - group_of(2)),
               'high card' => values(cards - [highest_card]) }
    values[rate]
  end

  private

  def values(other_cards)
    values = []
    other_cards.each { |card| values << card.value }
    values.sort.reverse
  end

  def group_cards
    cards.group_by(&:value)
  end

  def group_of?(card_quantity)
    group_cards.each do |_value, cards|
      return true if cards.length == card_quantity
    end
    false
  end

  def group_of(card_quantity)
    group_cards.each do |_value, cards|
      return cards if cards.length == card_quantity
    end
  end

  def highest_card
    cards.max
  end

  def straight?
    cards.max.value - cards.min.value == 4
  end

  def same_suit?
    suits = Hash.new(0)
    cards.each { |card| suits[card.suit] += 1 }
    suits.max[1] == 5
  end

  def <=>(other)
    if points == other.points
      high_card.value <=> other.high_card.value
    else
      points <=> other.points
    end
  end
end
