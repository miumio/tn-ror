require_relative "train"
require_relative 'train_types'

class CargoTrain < Train

  def initialize(wagons = 0)
    super(TRAIN_TYPES[:cargo], wagons)
  end

end
