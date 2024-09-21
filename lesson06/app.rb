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

  MENU = [
    {
      name: "Создать станцию",
      action: :create_station
    },
    {
      name: "Создать поезд",
      action: :create_train
    },
    {
      name: "Создать маршрут",
      action: :create_route
    },
    {
      name: "Добавить/удалить станцию в маршруте",
      action: :route_actions
    },
    {
      name: "Назначить маршрут поезду",
      action: :assign_route
    },
    {
      name: "Добавить вагон к поезду",
      action: :add_wagon
    },
    {
      name: "Отцепить вагон от поезда",
      action: :remove_wagon
    },
    {
      name: "Переместить поезд по маршруту",
      action: :move_train
    },
    {
      name: "Просмотреть список станций",
      action: :print_stations
    },
    {
      name: "Просмотреть список маршрутов",
      action: :print_routes
    },
    {
      name: "Просмотреть список поездов",
      action: :print_trains
    },
    {
      name: "Просмотреть список поездов на станции",
      action: :print_station_trains
    },
    {
      name: "Выход",
      action: :exit
    }
  ]

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
    action = MENU[choice - 1][:action]
    send(action)
  end

  def print_menu
    MENU.each_with_index { |item, i| puts "#{i + 1}. #{item[:name]}" }
  end

  def seed
    puts "Создание станций..."
    seed_stations
    puts "Создание поездов..."
    seed_trains
    puts "Создание маршрутов..."
    seed_routes
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
    trains << PassengerTrain.new("e33-22")
    trains << CargoTrain.new("e33-22")
  end

  def seed_routes
    5.times do
      start_index = rand(0...stations.size - 1)
      finish_index = rand(start_index + 1...stations.size)
      routes << Route.new(stations[start_index], stations[finish_index])
    end
  end


  def create_station
    new_station = nil
    loop do
      begin
        puts "Введите название станции:"
        name = gets.chomp
        new_station = Station.new(name)
        break
      rescue RuntimeError => e
        puts e
      end
    end
    
    puts "Станция #{new_station.name} создана"
    stations << new_station
  end

  def create_train
    puts "Выберите тип поезда:"
    puts "1. Пассажирский"
    puts "2. Грузовой"
    type = gets.chomp.to_i

    train = nil
    loop do
      begin
        puts "Введите номер поезда:"
        number = gets.chomp
        case type
          when 1
            train = PassengerTrain.new(number)
          when 2
            train = CargoTrain.new(number)
        end
        break
      rescue RuntimeError => e
        puts e
      end
    end

    puts "Поезд #{train.number} создан"
    trains << train
  end

  def create_route
    from = nil
    to = nil
    loop do
      begin
        puts "Выберите начальную станцию:"
        from = gets.chomp.to_i
        puts "Выберите конечную станцию:"
        to = gets.chomp.to_i
        break
      rescue RuntimeError => e
        puts e
      end
    end
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

  def print_trains
    trains.each_with_index { |train, index| puts "поезд№ #{train.number}(#{train.type})" }
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
    print_trains
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
