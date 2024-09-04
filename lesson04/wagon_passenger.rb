require_relative "wagon"
require_relative 'wagon_types'

class PassengerWagon < Wagon
  def initialize
    super(TRAIN_TYPES[:passenger])
  end
end