# Идеальный вес. Программа запрашивает у пользователя имя и рост и выводит идеальный вес по формуле 
# (<рост> - 110) * 1.15, после чего выводит результат пользователю на экран с обращением по имени. 
# Если идеальный вес получается отрицательным, то выводится строка "Ваш вес уже оптимальный"

print "Как вас зовут? "
name = gets.chomp
print "Какой ваш рост? "
height = gets.chomp.to_i
ideal_weight = (height - 110) * 1.15
msg = ideal_weight < 0 ? "Ваш вес уже оптимальный" : "Ваш идеальный вес: #{ideal_weight}"
puts "#{name}, #{msg}"