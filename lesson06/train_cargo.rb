require_relative "train"
require_relative 'train_types'

class CargoTrain < Train

  def initialize()
    super(TRAIN_TYPES[:cargo])
  end

end
