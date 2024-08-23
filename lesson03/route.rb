#Класс Route (Маршрут):
# Имеет начальную и конечную станцию, а также список промежуточных станций.
# Начальная и конечная станции указываютсся при создании маршрута,
# а промежуточные могут добавляться между ними.
# Может добавлять промежуточную станцию в список
# Может удалять промежуточную станцию из списка
# Может выводить список всех станций по-порядку от начальной до конечной

class Route
  attr_reader :route

  def initialize(start, finish)
    @start = start
    @finish = finish
    @points = []
    @route = [@start, @points, @finish]
  end

  def add_point(point)
    @points << point
  end

  def remove_point(point)
    @points.delete(point)
  end
end