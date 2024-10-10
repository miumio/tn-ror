require './modules/instance_counter'
require './modules/validate'

class Station
  include InstanceCounter
  include Validate
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

  def trains_block(&b)
    @trains.each(&b)
  end

  protected

  def validate!
    raise 'Название станции должно содержать больше двух символов' if name.length < 2
  end
end
