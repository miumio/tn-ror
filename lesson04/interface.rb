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
    routes << Route.new(@stations[from], @stations[to])
    puts "Маршрут #{from} - #{to} создан"
  end

  def route_actions
    puts "Выберите действие:"
    puts "1. Добавить станцию"
    puts "2. Удалить станцию"
    action = gets.chomp.to_i
    if action == 1
      add_station
    else
      remove_station
    end

    def print_route
      route.stations.each { |station, i| puts "#{i + 1}: #{station.name}" }
    end

    def add_station
      puts "Выберите станцию:"
      print_route
      index = gets.chomp.to_i - 1
      route.add_station(@stations[index])
      puts "Станция #{station} добавлена в маршрут"
    end

    def remove_station
      puts "Выберите станцию:"
      print_route
      index = gets.chomp.to_i - 1
      route.remove_station(@stations[index])
      puts "Станция #{station} удалена из маршрута"
    end
  end

  def assign_route
  end

  def add_wagon
  end

  def remove_wagon
  end

  def move_train
  end

  def show_stations_and_trains
  end

end
