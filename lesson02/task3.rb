# Заполнить массив числами фибоначчи до 100

def fib
  arr = [0, 1]
  while arr.last < 100
    arr << arr[-2] + arr[-1]
  end
  return arr
end
puts fib
