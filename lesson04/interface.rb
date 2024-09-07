require_relative 'station'
require_relative 'train'
require_relative 'route'
require_relative 'wagon'

class Interface
  def initialize
    @wagons = []
    @trains = []
    @routes = []
    @stations = []
  end

  def menu
    loop do
      puts "Выберите действие:"
      puts "1. Создать станцию"
      puts "2. Создать поезд"
      puts "3. Создать маршрут"
      puts "4. Добавить/удалить станцию в маршруте"
      puts "5. Назначить маршрут поезду"
      puts "6. Добавить вагон к поезду"
      puts "7. Отцепить вагон от поезда"
      puts "8. Переместить поезд по маршруту"
      puts "9. Просмотреть список станций и список поездов на станции"
      puts "10. Выход"
      choice = gets.chomp.to_i
      case choice
        when 1
          create_station
        when 2
          create_train
        when 3
          create_route
        when 4
          route_actions
        when 5
          assign_route
        when 6
          add_wagon
        when 7
          remove_wagon
        when 8
          move_train
        when 9
          show_stations_and_trains
        when 10
          break
        else
          puts "Некорректный ввод"
      end
    end
  end

  #self methods 
  private

  attr_reader :trains, :routes, :stations

  def create_station
    puts "Введите название станции:"
    name = gets.chomp
    stations << Station.new(name)
    puts "Станция #{name} создана"
  end

  def create_train
    puts "Выберите тип поезда:"
    puts "1. Пассажирский"
    puts "2. Грузовой"
    type = gets.chomp.to_i
    if type == 1
      trains << PassengerTrain.new
    else
      trains << CargoTrain.new
    end
    puts "Поезд #{number} создан"
  end

  def create_route
    puts "Выберите начальную станцию:"
    from = gets.chomp
    puts "Выберите конечную станцию:"
    to = gets.chomp
    routes << Route.new(stations[from], stations[to])
    puts "Маршрут #{from} - #{to} создан"
  end

  def route_actions
    puts "Выберите действие:"
    puts "1. Добавить станцию"
    puts "2. Удалить станцию"
    action = gets.chomp.to_i
  
    case action
      when 1
        add_station_to_route
      when 2
        remove_station_from_route
      else
        puts "Некорректный ввод"
    end
  end

  def print_routes
    routes.each_with_index do |route, i| 
      puts "#{i}: #{route.stations.first.name} - #{route.stations.last.name}"
    end
  end

    
  def print_route_stations(route)
    route.stations.each_with_index do |station, i|
      puts "#{i}: #{station.name}"
    end
  end

  def add_station_to_route
    puts "Выберите маршрут:"
    print_routes
    choice = gets.chomp.to_i
    route = routes[choice]
    return if choise.negative? || choise > routes.size
  
    puts "Выберите станцию:"
    print_route_stations(route)
    station_index = gets.chomp.to_i
    station = @stations[station_index]
  
    route.add_station(station)
    puts "Станция #{station.name} добавлена в маршрут"
  end

  def remove_station_from_route
    puts "Выберите маршрут:"
    print_routes
    choice = gets.chomp.to_i
    route = routes[choice]
    
    puts "Выберите станцию:"
    print_route_stations(route)
    station_index = gets.chomp.to_i
    station = route.stations[station_index]
  
    route.remove_station(station)
    puts "Станция #{station.name} удалена из маршрута"
  end

  def assign_route
    puts "Выберите маршрут:"
    print_routes
    route = gets.chomp.to_i

    train = choose_train
    train.assign_route(routes[route])
  end

  def choose_train
    puts 'Выберите поезд:'
    trains.each_with_index { |train, index| puts "#{index}: #{train.number}" }
    input = gets.to_i
    return if input < 0 || input >= trains.size
    trains[input]
  end

  def add_wagon(wagon = nil)
    choose_train
    puts "Выберите вагон:"
    puts "1. Пассажирский"
    puts "2. Грузовой"
    type = gets.chomp.to_i

    case type
      when 1
        wagon = PassengerWagon.new
      when 2
        wagon = CargoWagon.new
    end

    trains[train].add_wagon(wagon)
  end

  def remove_wagon
    train =choose_train
    trains[train].remove_wagon
  end

  def move_train
  end

  def show_stations_and_trains
  end

end
