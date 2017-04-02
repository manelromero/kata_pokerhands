class Result
  attr_reader :hands
  def initialize(hands)
    @hands = []
    hands.each do |hand|
      @hands << PokerHand.new(hand)
    end
  end

  def quote
    <<~EOL.delete("\n")
    #{best_hand.player} wins with #{best_hand.high_card.name}
    -high #{best_hand.rate}
    EOL
  end

  private

  def best_hand
    @hands.max
  end
end
