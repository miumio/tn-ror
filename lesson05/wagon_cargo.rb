require_relative "wagon"
require_relative 'train_types'

class CargoWagon < Wagon
  def initialize
    super(TRAIN_TYPES[:cargo])
  end
end