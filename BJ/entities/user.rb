require_relative 'player'

class User < Player

  def move
    puts "Your cards: #{cards.map(&:to_s).join(', ')}"
    puts "Your points: #{points}"
    puts "Do you want to (1) take a card, (2) skip, or (3) open cards?"
    choice = gets.strip.to_i
    
    case choice
    when 1 then :take
    when 2 then :skip
    when 3 then :open
    else
      puts "Invalid choice, skipping turn."
      :skip
    end
  end
end 