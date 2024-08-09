# Квадратное уравнение. Пользователь вводит 3 коэффициента a, b и с. 
# Программа вычисляет дискриминант (D) и корни уравнения (x1 и x2, если они есть) 
# и выводит значения дискриминанта и корней на экран. При этом возможны следующие варианты:
#   Если D > 0, то выводим дискриминант и 2 корня
#   Если D = 0, то выводим дискриминант и 1 корень (т.к. корни в этом случае равны)
#   Если D < 0, то выводим дискриминант и сообщение "Корней нет"
# Подсказка: Алгоритм решения с блок-схемой (www.bolshoyvopros.ru). 
# Для вычисления квадратного корня, нужно использовать  

def get_coefficient(name)
  puts "Введите коэффициент #{name}:"
  loop do
    input = gets.chomp
    begin
      coefficient = Float(input)
      return coefficient
    rescue ArgumentError
      puts "Ошибка: некорректное значение. Пожалуйста, введите число:"
    end
  end
end

a = get_coefficient('a')
b = get_coefficient('b')
c = get_coefficient('c')

d = b**2 - 4 * a * c

if d < 0
  puts "Дискриминант: #{d}\nКорней нет"
elsif d == 0
  x = -b / (2 * a)
  puts "Дискриминант: #{d}\nКорень: x = #{x}"
else
  x1 = (-b + Math.sqrt(d)) / (2 * a)
  x2 = (-b - Math.sqrt(d)) / (2 * a)
  puts "Дискриминант: #{d}\nКорни: x1 = #{x1}, x2 = #{x2}"
end