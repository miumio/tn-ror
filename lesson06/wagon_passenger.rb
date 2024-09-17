require_relative "wagon"
require_relative 'train_types'

class PassengerWagon < Wagon
  def initialize
    super(TRAIN_TYPES[:passenger])
  end
end