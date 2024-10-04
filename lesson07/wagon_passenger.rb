require_relative "wagon"
require_relative 'train_types'

class PassengerWagon < Wagon
  attr_reader :seats 
  DEFAULT_SEATS = 116

  def initialize(seats = DEFAULT_SEATS)
    super(TRAIN_TYPES[:passenger])
    @seats_count = seats
    @seats = seats
  end

  def take_seat
    return if @seats == 0
    @seats -= 1
  end

  def free_seats
    @seats
  end

  def occupied_seats
    @seats_count - @seats
  end
end