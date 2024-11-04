require_relative 'station'
require_relative 'train'
require_relative 'route'
require_relative 'train_passenger'
require_relative 'train_cargo'
require_relative 'wagon'
require_relative 'wagon_passenger'
require_relative 'wagon_cargo'

# rubocop:disable Metrics/ClassLength
class App
  attr_reader :trains, :routes, :stations

  MENU = [
    {
      name: 'Создать станцию',
      action: :create_station
    },
    {
      name: 'Создать поезд',
      action: :create_train
    },
    {
      name: 'Создать маршрут',
      action: :create_route
    },
    {
      name: 'Добавить/удалить станцию в маршруте',
      action: :route_actions
    },
    {
      name: 'Назначить маршрут поезду',
      action: :assign_route
    },
    {
      name: 'Добавить вагон к поезду',
      action: :add_wagon
    },
    {
      name: 'Отцепить вагон от поезда',
      action: :remove_wagon
    },
    {
      name: 'Переместить поезд по маршруту',
      action: :move_train
    },
    {
      name: 'Просмотреть список станций',
      action: :print_stations
    },
    {
      name: 'Просмотреть список маршрутов',
      action: :print_routes
    },
    {
      name: 'Просмотреть список поездов',
      action: :print_trains
    },
    {
      name: 'Просмотреть список поездов на станции',
      action: :print_station_trains
    },
    {
      name: 'Просмотреть количество вагонов у поезда',
      action: :print_train_wagons
    },
    {
      name: 'Занять место или объем в вагоне',
      action: :use_wagon
    },
    {
      name: 'Выход',
      action: :exit
    }
  ].freeze

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

  # self methods
  private

  def menu_actions(choice)
    action = MENU[choice - 1][:action]
    send(action)
  end

  def print_menu
    MENU.each_with_index { |item, i| puts "#{i + 1}. #{item[:name]}" }
  end

  def seed
    puts 'Создание станций...'
    seed_stations
    puts 'Создание поездов...'
    seed_trains
    puts 'Создание маршрутов...'
    seed_routes
  end

  def seed_stations
    station_names = %w(
      Санкт-Петербург, Москва, Новосибирск, Казань, Eкатеринбург, Омск, Владивосток,
      Волгоград, Краснодар, Сочи, Ростов-на-Дону, Уфа, Тюмень, Нижний Новгород,
      Красноярск, Челябинск, Оренбург, Самара, Калининград, Воронеж, Белгород,
      Томск, Кемерово, Саратов
    )

    station_names.each do |name|
      stations << Station.new(name)
    end
  end

  def seed_trains
    trains << PassengerTrain.new('e33-22')
    trains << CargoTrain.new('e33-22')
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
      puts 'Введите название станции:'
      name = gets.chomp
      new_station = Station.new(name)
      break
    rescue RuntimeError => e
      puts e
    end

    puts "Станция #{new_station.name} создана"
    stations << new_station
  end

  def create_train
    puts 'Выберите тип поезда:'
    puts '1. Пассажирский'
    puts '2. Грузовой'
    type = gets.chomp.to_i

    train = nil
    loop do
      puts 'Введите номер поезда:'
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

    puts "Поезд #{train.number} создан"
    trains << train
  end

  def create_route
    from = nil
    to = nil
    loop do
      puts 'Выберите начальную станцию:'
      from = gets.chomp.to_i
      puts 'Выберите конечную станцию:'
      to = gets.chomp.to_i
      break
    rescue RuntimeError => e
      puts e
    end
    routes << Route.new(stations[from], stations[to])
    puts "Маршрут #{stations[from].name} - #{stations[to].name} создан"
  end

  def route_actions
    route = choose_route
    puts 'Вы выбрали маршрут: '
    route.print

    puts 'Выберите действие:'
    puts '1. Добавить станцию'
    puts '2. Удалить станцию'
    action = gets.chomp.to_i

    case action
    when 1
      add_station_to_route(route)
    when 2
      remove_station_from_route(route)
    else
      puts 'Некорректный ввод'
    end
  end

  def print_routes
    routes.each_with_index do |route, i|
      puts "#{i}: "
      puts route.print
    end
  end

  def print_route_stations(route)
    puts 'Список станций в маршруте:'
    route.print
  end

  def print_stations
    stations.each_with_index do |station, i|
      puts "#{i}: #{station.name}"
    end
  end

  def print_trains
    trains.each_with_index { |train, _index| puts "поезд№ #{train.number}(#{train.type})" }
  end

  def add_station_to_route(route)
    puts 'Выберите станцию:'
    print_stations
    station_index = gets.chomp.to_i
    station = @stations[station_index]

    route.add_station(station)
  end

  def remove_station_from_route(route)
    puts 'Выберите станцию:'
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
    trains[input - 1]
  end

  def choose_route
    puts 'Выберите маршрут:'
    print_routes
    choice = gets.chomp.to_i
    routes[choice]
  end

  def choose_station
    puts 'Выберите станцию:'
    print_stations
    choice = gets.chomp.to_i
    stations[choice]
  end

  def add_wagon
    train = choose_train
    puts 'Выберите вагон:'
    puts '1. Пассажирский'
    puts '2. Грузовой'
    type = gets.chomp.to_i

    case type
    when 1
      puts 'Сколько мест в вагоне?'
      seats = gets.chomp.to_i
      wagon = PassengerWagon.new(seats)
    when 2
      puts 'Укажите объем в вагоне'
      volume = gets.chomp.to_i
      wagon = CargoWagon.new(volume)
    end

    train.add_wagon(wagon)
  end

  def remove_wagon
    train = choose_train
    train.remove_wagon
  end

  def move_train
    train = choose_train
    puts 'Выберите направление:'
    puts '1. Вперед'
    puts '2. Назад'
    direction = gets.chomp.to_i
    train.go_next_station if direction == 1
    train.go_previous_station if direction == 2
  end

  def print_station_trains
    station = choose_station
    puts "Список поездов на станции #{station.name}:"
    station.trains_block do |train|
      puts "поезд№ #{train.number}(#{train.type})"
    end
  end

  def print_train_wagons
    train = choose_train

    puts "Список вагонов поезда ##{train.number}(#{train.type}):"
    if train.wagons.empty?
      puts 'Вагонов нет'
      return
    end
    train.wagon_block do |wagon|
      case wagon
      when PassengerWagon
        print_passenger_info(wagon)
      when CargoWagon
        print_cargo_info(wagon)
      end
    end
    train
  end

  def print_passenger_info(wagon)
    puts "    Тип вагона №#{wagon.number}: пассажирский"
    puts "         Общее Количество мест: #{wagon.seats}"
    puts "         Количество свободных мест: #{wagon.free_seats}"
    puts "         Количество занятых мест: #{wagon.used_seats}"
  end

  def print_cargo_info(wagon)
    puts "    Тип вагона №#{wagon.number}: пассажирский"
    puts "         Общее Количество мест: #{wagon.seats}"
    puts "         Количество свободных мест: #{wagon.free_seats}"
    puts "         Количество занятых мест: #{wagon.used_seats}"
  end

  def use_wagon
    train = print_train_wagons
    puts 'Выберите вагон:'
    choice = gets.chomp
    wagon = train.wagons.find { |w| w.number == choice }
    case wagon
    when PassengerWagon
      puts 'Сколько мест вы хотите занять?'
      wagon.take_seat(gets.chomp.to_i)
    when CargoWagon
      puts 'Сколько объема вы хотите занять?'
      wagon.take_volume(gets.chomp.to_i)
    end
  end
end
# rubocop:enable Metrics/ClassLength
