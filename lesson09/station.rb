require './modules/instance_counter'
require './modules/validation'
require './modules/accessors'

class Station
  include InstanceCounter
  include Validation
  extend Accessors

  attr_reader :name, :trains
  attr_accessor_with_history :name, :trains
  strong_attr_accessor :name, String

  validate :name, :presence

  def initialize(name)
    @name = name
    @trains = []
    validate!
    register_instance
  end

  def send_train(train)
    @trains.delete(train)
  end

  def get_train_by_type(type)
    @trains.select { |train| train.type == type }
  end

  def trains_block(&block)
    @trains.each(&block)
  end
end
