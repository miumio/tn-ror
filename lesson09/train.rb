require './modules/manufacturer'
require './modules/instance_counter'
require './modules/validation'
require './modules/accessors'

class Train
  include Manufacturer
  include InstanceCounter
  include Validation
  extend Accessors

  NUMBER_REGEXP = /^[a-zа-я0-9]{3}-?[a-zа-я0-9]{2}$/

  attr_reader :number, :type, :wagons
  attr_accessor_with_history :route, :speed
  strong_attr_accessor :current_station_index, Integer
  strong_attr_accessor :speed, Integer
  strong_attr_accessor :number, String

  validate :number, :format, NUMBER_REGEXP

  @all = []

  def self.find(number)
    @all.find { |train| train.number == number }
  end

  def initialize(type, number)
    @number = number
    validate!
    @type = type
    @speed = 0
    @wagons = []
    register_instance
  end

  def speed_up(amount)
    @speed += amount
  end

  def stop
    @speed = 0
  end

  def add_wagon(wagon)
    if @speed.positive?
      puts 'Ошибка! Остановите поезд перед добавлением вагона'
      return
    end

    @wagons << wagon if wagon_is_valid?(wagon)
  end

  def remove_wagon
    if @speed.positive?
      puts 'Ошибка! Остановите поезд перед удалением вагона'
      return
    end

    if @wagons.empty?
      puts 'Ошибка! Вагонов нет'
      return
    end

    @wagons.pop
  end

  def assign_route(route)
    @route = route
    @current_station_index = 0
  end

  def current_station
    route.stations[current_station_index]
  end

  def next_station
    route.stations[current_station_index + 1]
  end

  def previous_station
    return if current_station_index.zero?

    route.stations[current_station_index - 1]
  end

  def go_next_station
    @current_station_index += 1 if next_station
  end

  def go_previous_station
    @current_station_index -= 1 if previous_station
  end

  def wagon_block(&block)
    @wagons.each(&block)
  end

  private

  def wagon_is_valid?(wagon)
    wagon.type == type
  end

  attr_reader :route, :current_station_index
end
