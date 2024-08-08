# Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).

letters = ('a'..'z')
letters_arr = letters.to_a

hash = {}
letters_arr.each_with_index do |letter, index|
    if letter.match(/[aeiouy]/) do hash[letter] = index + 1 end
  end
end
puts hash
