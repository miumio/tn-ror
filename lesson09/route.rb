require './modules/instance_counter'
require './modules/validation'

class Route
  include InstanceCounter
  include Validation
  attr_reader :stations

  validate :start, :type, Station
  validate :finish, :type, Station

  def initialize(start, finish)
    @start = start
    @finish = finish
    validate!
    @points = []
    @stations = [@start, @points, @finish].flatten
    register_instance
  end

  def add_station(point)
    return if @stations.detect { |station| station.name == point.name }
    return if @points.detect { |station| station.name == point.name }

    @points << point
    @stations = [@start, @points, @finish].flatten
  end

  def remove_station(point)
    @points.delete(point)
    @stations = [@start, @points, @finish].flatten
  end

  def print
    if @points.empty?
      puts "#{@start.name} - #{@finish.name}"
    else
      puts "#{@start.name} - #{@points.map(&:name).join(' - ')} - #{@finish.name}"
    end
  end
end
