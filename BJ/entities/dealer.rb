require_relative "player"

class Dealer < Player

  def move
    if points < 17 ? :take : :skip
  end

end 

