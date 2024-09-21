require './modules/instance_counter'

class Station
  include InstanceCounter
  attr_reader :name, :trains

  @@all = []

  def self.all
    @@all
  end

  def initialize(name)
    @name = name
    @trains = []
    @@all << self
    register_instance
    validate!
  end

  def train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def get_train_by_type(type)
    @trains.select { |train| train.type == type }
  end

  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end

  protected

  def validate!
    raise "Название станции не может быть пустым" if name.empty?
    raise "Название станции должно содержать больше двух символов" if name.length < 2

    rescue StandardError => e
      print_error(e)
  end
end