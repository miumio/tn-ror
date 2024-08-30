require_relative "train"
require_relative 'train_types'

class PassengerTrain < Train
  def initialize(wagons = 0)
    super(TRAIN_TYPES[:passenger], wagons)
  end
end