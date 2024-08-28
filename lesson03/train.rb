class Train
  attr_reader :number, :type, :wagons_count, :speed, :current_station, :previous_station, :next_station

  def initialize(type, wagons)
    @number = rand(1...1000).to_s
    @type = type
    @wagons_count = wagons
    @speed = 0
    @stations = []
    @current_station_index = nil
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

    @wagons_count += 1
  end

  def remove_wagon
    if @speed > 0
      puts "Ошибка! Остановите поезд перед удалением вагона"
      return
    end

    if @wagons_count == 0
      puts "Ошибка! Вагонов нет"
      return
    end

    @wagons_count -= 1
  end

  def assign_route(route)
    if route.size < 2
      puts "Ошибка! Маршрут должен состоять минимум из двух станций"
      return
    end

    @stations = route
    @current_station_index = 0
    update_stations
  end

  def move_forward
    if @current_station_index.nil? || @current_station_index == @stations.size - 1
      puts "Ошибка! поезд на конечной станции"
      return
    end

    @current_station_index += 1
    update_stations
  end

  def move_backward
    if @current_station_index.nil? || @current_station_index == 0
      puts "Ошибка! поезд на первой станции"
      return
    end

    @current_station_index -= 1
    update_stations
  end

  private

  def update_stations
    @current_station = @stations[@current_station_index]
    @previous_station = @current_station_index > 0 ? @stations[@current_station_index - 1] : nil
    @next_station = @current_station_index < @stations.size - 1 ? @stations[@current_station_index + 1] : nil
  end
end
