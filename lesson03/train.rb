class Train
  attr_reader :number, :type, :wagons, :speed, :current_station, :previous_station, :next_station

  def initialize(type, wagons)
    @number = rand(1...1000).to_s
    @type = type
    @wagons = wagons
    @speed = 0
  end

  def speed_up(amount)
    @speed += amount
  end

  def stop
    @speed = 0
  end

  def add_wagon
    if @speed > 0
      puts "Ошибка! Остановите поезд перед добавлением вагона"
      return
    end

    @wagons += 1
  end

  def remove_wagon
    if @speed > 0
      puts "Ошибка! Остановите поезд перед удалением вагона"
      return
    end

    if @wagons == 0
      puts "Ошибка! Вагонов нет"
      return
    end

    @wagons -= 1
  end

  def assign_route(route)
    if route.size < 2
      puts "Ошибка! Маршрут должен состоять минимум из двух станций"
      return
    end

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
    return if current_station_index == 0
    route.stations[current_station_index - 1]
  end

  def go_next_station
    @current_station_index += 1 if next_station
  end

  def go_previous_station
    @current_station_index -= 1 if previous_station
  end

  private

  attr_reader :route, :current_station_index
end
