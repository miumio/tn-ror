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
    # todo
    result = Round.new(players, deck).play
  end

  def calc_results
  end
end
