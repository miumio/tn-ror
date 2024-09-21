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
    validate!
    register_instance
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
    raise "Название станции должно содержать больше двух символов" if name.length < 2
  end
end