class Train
  attr_reader :number, :type, :wagons, :speed, :current_station, :previous_station, :next_station

  def initialize(type)
    set_number
    @type = type
    @speed = 0
    @wagons = []
  end

  def speed_up(amount)
    @speed += amount
  end

  def stop
    @speed = 0
  end

  def add_wagon(wagon)
    if @speed > 0
      puts "Ошибка! Остановите поезд перед добавлением вагона"
      return
    end

    @wagons << wagon if wagon_is_valid?(wagon)
  end

  def remove_wagon
    if @speed > 0
      puts "Ошибка! Остановите поезд перед удалением вагона"
      return
    end

    if @wagons.empty?
      puts "Ошибка! Вагонов нет"
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
  
  def wagon_is_valid?(wagon)
    wagon.type == self.type
  end
  #в привате, так как нужен только при создании экземпляра
  @@count = 0
  @number
  
  def set_number
    @number = @@count + 1
    @@count += 1
  end

  attr_reader :route, :current_station_index
end
