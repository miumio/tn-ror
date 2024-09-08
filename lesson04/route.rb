#Класс Route (Маршрут):
# Имеет начальную и конечную станцию, а также список промежуточных станций.
# Начальная и конечная станции указываютсся при создании маршрута,
# а промежуточные могут добавляться между ними.
# Может добавлять промежуточную станцию в список
# Может удалять промежуточную станцию из списка
# Может выводить список всех станций по-порядку от начальной до конечной

class Route
  attr_reader :stations

  def initialize(start, finish)
    @start = start
    @finish = finish
    @points = []
    @stations = [@start, @points, @finish].flatten
  end

  def add_station(point)
    return if @stations.detect { |station| station.name == point.name }
    return if @points.detect { |station| station.name == point.name }
    @points << point
    puts "Станция #{point.name} добавлена в маршрут"
  end

  def remove_station(point)
    @points.delete(point)
  end

  def print
    if @points.empty?
      puts "#{@start.name} - #{@finish.name}"
    else
      puts "#{@start.name} - #{@points.map(&:name).join(' - ')} - #{@finish.name}"
    end
  end
end