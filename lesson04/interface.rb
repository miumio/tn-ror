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
      puts "6. Добавить/удалить вагон к поезду"
      puts "7. Прицепить/выцепить вагон к поезду"
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
          add_or_remove_station
        when 5
          assign_route
        when 6
          add_or_remove_wagon
        when 7
          add_or_remove_wagon
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
end