require_relative "station"
require_relative "train"
require_relative "route"
require_relative "train_passenger"
require_relative "train_cargo"
require_relative "wagon"
require_relative "wagon_passenger"
require_relative "wagon_cargo"

class App
  attr_reader :trains, :routes, :stations

  def initialize
    @wagons = []
    @trains = []
    @routes = []
    @stations = []
    seed
  end

  def menu
    loop do
      print_menu
      choice = gets.chomp.to_i
      menu_actions(choice)
    end
  end

  #self methods 
  private

  def menu_actions(choice)
    case choice
      when 1 then create_station
      when 2 then create_train
      when 3 then create_route
      when 4 then route_actions
      when 5 then assign_route
      when 6 then add_wagon
      when 7 then remove_wagon
      when 8 then move_train
      when 9 then print_stations
      when 10 then print_routes
      when 11 then print_station_trains
      when 0 then exit
    else
      puts "Некорректный ввод"
    end
  end

  def print_menu
    puts ""
    puts "Выберите действие:"
    puts "1. Создать станцию"
    puts "2. Создать поезд"
    puts "3. Создать маршрут"
    puts "4. Добавить/удалить станцию в маршруте"
    puts "5. Назначить маршрут поезду"
    puts "6. Добавить вагон к поезду"
    puts "7. Отцепить вагон от поезда"
    puts "8. Переместить поезд по маршруту"
    puts "9. Просмотреть список станций"
    puts "10. Просмотреть список маршрутов"
    puts "11. Просмотреть список поездов на станции"
    puts "0. Выход"
    puts ""
  end

  def seed
    puts "Создание станций..."
    seed_stations
    puts "Создание поездов..."
    seed_trains
    puts "Создание маршрутов..."
    seed_routes
    # puts "Создание вагонов..."
    # seed_wagons
  end

  def seed_stations
    station_names = [
      "Санкт-Петербург", "Москва", "Новосибирск", "Казань", "Eкатеринбург", "Омск", "Владивосток",
      "Волгоград", "Краснодар", "Сочи", "Ростов-на-Дону", "Уфа", "Тюмень", "Нижний Новгород",
      "Красноярск", "Челябинск", "Оренбург", "Самара", "Калининград", "Воронеж", "Белгород",
      "Томск", "Кемерово", "Саратов"
    ]

    station_names.each do |name|
      stations << Station.new(name)
    end
  end

  def seed_trains
    trains << PassengerTrain.new
    trains << CargoTrain.new
  end

  def seed_routes
    5.times do
      start_index = rand(0...stations.size - 1)
      finish_index = rand(start_index + 1...stations.size)
      routes << Route.new(stations[start_index], stations[finish_index])
    end
  end


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
    case type
      when 1
        train = PassengerTrain.new
      when 2
        train = CargoTrain.new
    end
    puts "Поезд #{train.number} создан"
    trains << train
  end

  def create_route
    puts "Выберите начальную станцию:"
    from = gets.chomp.to_i
    puts "Выберите конечную станцию:"
    to = gets.chomp.to_i
    routes << Route.new(stations[from], stations[to])
    puts "Маршрут #{stations[from].name} - #{stations[to].name} создан"
  end

  def route_actions
    route = choose_route
    puts "Вы выбрали маршрут: "
    route.print

    puts "Выберите действие:"
    puts "1. Добавить станцию"
    puts "2. Удалить станцию"
    action = gets.chomp.to_i
  
    case action
      when 1
        add_station_to_route(route)
      when 2
        remove_station_from_route(route)
      else
        puts "Некорректный ввод"
    end
  end

  def print_routes
    routes.each_with_index do |route, i| 
      puts "#{i}: "
      puts "#{route.print}"
    end
  end

    
  def print_route_stations(route)
    puts "Список станций в маршруте:"
    route.print
  end

  def print_stations
    stations.each_with_index do |station, i|
      puts "#{i}: #{station.name}"
    end
  end

  def add_station_to_route(route)  
    puts "Выберите станцию:"
    print_stations
    station_index = gets.chomp.to_i
    station = @stations[station_index]

    route.add_station(station)
  end

  def remove_station_from_route(route)
    puts "Выберите станцию:"
    print_stations
    station_index = gets.chomp.to_i
    station = @stations[station_index]  
    route.remove_station(station)
  end

  def assign_route
    train = choose_train
    route = choose_route

    train.assign_route(route)
    puts "Поезд #{train.number} назначен маршруту:"
    route.print
  end

  def choose_train
    puts 'Выберите поезд:'
    trains.each_with_index { |train, index| puts "поезд№ #{train.number}(#{train.type})" }
    input = gets.to_i
    train = trains.find { |train| train.number == input }
    train
  end

  def choose_route
    puts "Выберите маршрут:"
    print_routes
    choice = gets.chomp.to_i
    route = routes[choice]
    route
  end

  def add_wagon()
    train = choose_train
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

    train.add_wagon(wagon)
  end

  def remove_wagon
    train = choose_train
    train.remove_wagon
  end

  def move_train
    train = choose_train
    puts "Выберите направление:"
    puts "1. Вперед"
    puts "2. Назад"
    direction = gets.chomp.to_i
    train.go_next_station if direction == 1
    train.go_previous_station if direction == 2
  end

  def print_station_trains
    puts "Выберите станцию:"
    print_stations
    station_index = gets.chomp.to_i
    station = @stations[station_index]
    station.trains.each_with_index { |train, index| puts "поезд№ #{train.number}(#{train.type})" }
  end
end
