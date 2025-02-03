class Game
  def initialize
    @players = [Player.new, Dealer.new]
    @deck = Deck.new
  end

  def start
    loop do
      take_bets
      play_round
      calc_results
    end
  end

  private

  def take_bets
  end

  def play_round
    round = Round.new(players, deck)
    round.start
  end

  def calc_results
  end
end

class Deck
  def initialize
    @cards = []
    @cards = 52.times... @cards << Card.new
  end

  def deal_card
    generate_deck if @cards.empty?
    @cards.pop
  end

  private

  def generate_deck
  end

  def shuffle
  end

end

class Round
  def initialize(players, deck)
    @players = players
    @deck = deck
  end

  def start
    prepare
    make_moves
  end

  private
  
  def prepare
    players.each do |player|
      2.times do
        player.cards = deck.deal_card
      end
  end

  def make_moves
    players.each do |player|
      move = player.move

      case move
      when :take
        player.cards = deck.deal_card
      when :open

    end
end

class Card
end

class Player
  @cards = []
  @credit = 100

  def points
    # -> 18
  end

end 

class Dealer < Player

  def move
    if points < 17 ? :take : :skip
  end

end 

class User < Player

  def move
    [:take, :skip, :open]
  end

end 