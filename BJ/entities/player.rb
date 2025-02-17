class Player
  attr_accessor :cards, :credit

  def initialize
    @cards = []
    @credit = 100
  end

  def points
    cards.each do |card|
      puts card.to_s
    end
  end

  def take(card)
    @cards << card
  end

  def skip
    puts "Игрок пропускает ход"
  end
end 
