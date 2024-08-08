# Заполнить массив числами от 10 до 100 с шагом 5

arr = []

for i in 10..100
  if i % 5 == 0 then arr << i end
end
puts arr