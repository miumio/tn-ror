class Player
  attr_accessor :cards, :credit

  def initialize
    @cards = []
    @credit = 100
  end

  def points
    # todo
    total = 0
    @cards.each { |card| card.value.class == Symbol ? total += 10 : total += card.value}

    total
  end

  def take(card)
    @cards << card
  end

  def skip
    puts "skip"
  end
end 
