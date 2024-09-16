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
end