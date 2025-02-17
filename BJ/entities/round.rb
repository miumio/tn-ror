require_relative 'dealer'
require_relative 'user'
require_relative 'deck'

class Round
  attr_reader :players, :deck
  
  def initialize
    @players = [User.new, Dealer.new]
    @deck = Deck.new
  end

  def play
    prepare
    make_moves
    results
  end

  private
  
  def prepare
    players.each do |player|
      2.times do
        player.cards = deck.take_card
      end
    end
  end

  def make_moves
    # players.each do |player|
    #   move = player.move

    #   case move
    #   when :take
    #     player.cards = deck.take_card
    #   when :open
    #     results
    #   end
    # end
  end

  def results
    puts "results"
    # ...

    # {
    #   result: 'winner',
    #   winner: players[0]

    # }
  end
end
