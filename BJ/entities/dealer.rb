require_relative "player"

class Dealer < Player
  def move
    points < 17 ? :take : :skip
  end
end 

