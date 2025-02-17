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
        player.take(deck.take_card)
      end
    end
  end

  def make_moves
    players.each do |player|
      while player.points < 21
        move = player.move

        case move
        when :take
          player.take(deck.take_card)
        when :skip
          player.skip
          break
        when :open
          break
        end
      end
    end
  end

  def results
    players.each { |player| puts "#{player.class}: #{player.points} points" }
    
    winners_list = players.select { |player| player.points <= 21 }
    
    return { result: 'draw', winner: nil } if winners_list.empty?
      
    if winners_list.length == 1
      { result: 'winner', winner: winners_list.first }
    else
      winner = winners_list.max_by(&:points)
      { result: 'winner', winner: winner }
    end
  end
end
