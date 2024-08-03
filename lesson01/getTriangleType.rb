# Прямоугольный треугольник. 
# Программа запрашивает у пользователя 3 стороны треугольника и определяет, 
# является ли треугольник прямоугольным (используя теорему Пифагора www-formula.ru), 
# равнобедренным (т.е. у него равны любые 2 стороны)  
# или равносторонним (все 3 стороны равны) и выводит результат на экран. 
# Подсказка: чтобы воспользоваться теоремой Пифагора, 
# нужно сначала найти самую длинную сторону (гипотенуза) 
# и сравнить ее значение в квадрате с суммой квадратов двух остальных сторон. 
# Если все 3 стороны равны, то треугольник равнобедренный и равносторонний, но не прямоугольный

print "Какая первая сторона треугольника? "
a = gets.chomp.to_i
print "Какая вторая сторона треугольника? "
b = gets.chomp.to_i
print "Какая третья сторона треугольника? "
c = gets.chomp.to_i

sides_arr = [a, b, c]

if a == b && b == c && c == a
    puts "Треугольник равносторонний"
    exit
end

hypotenuse = sides_arr.max

sides_arr.delete(hypotenuse)

sum_of_short_sides = sides_arr[0]**2 + sides_arr[1]**2

if hypotenuse**2 == sum_of_short_sides
    puts "Треугольник прямоугольный"
elsif a == b || b == c || a == c
    puts "Треугольник равнобедренный"
else
    puts "Треугольник общего типа"
end
