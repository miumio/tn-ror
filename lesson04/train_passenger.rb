require_relative "train"
require_relative 'train_types'

class PassengerTrain < Train
  def initialize()
    super(TRAIN_TYPES[:passenger])
  end
end