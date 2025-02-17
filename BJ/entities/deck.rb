require_relative "card"

class Deck
  RANKS = [2, 3, 4, 5, 6, 7, 8, 9, 10, :J, :Q, :K, :A]
  SUITS = ['❤︎', '♠', '♦', '♣']

  def initialize
    @cards = []
    generate_deck
    shuffle
  end

  def take_card
    generate_deck if @cards.empty?
    @cards.pop
  end

  private

  def generate_deck
    @cards = SUITS.product(RANKS).map { |suit, value| Card.new(suit, value) }
  end

  def shuffle
    @cards.shuffle!
  end
end
