class Game
  attr_reader :hands
  def initialize(*hands)
    @hands = hands
  end

  def result
    Result.new(hands).quote
  end
end
