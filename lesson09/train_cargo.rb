require_relative 'train'
require_relative 'train_types'

class CargoTrain < Train
  def initialize(number)
    super(TRAIN_TYPES[:cargo], number)
  end
end
