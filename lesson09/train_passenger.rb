require_relative 'train'
require_relative 'train_types'

class PassengerTrain < Train
  def initialize(number)
    super(TRAIN_TYPES[:passenger], number)
  end
end
