require './modules/instance_counter'

class Route
  include InstanceCounter
  attr_reader :stations

  def initialize(start, finish)
    @start = start
    @finish = finish
    @points = []
    @stations = [@start, @points, @finish].flatten
    register_instance
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