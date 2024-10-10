require_relative "wagon"
require_relative 'train_types'

class PassengerWagon < Wagon
  attr_reader :used_seats, :seats
  DEFAULT_SEATS = 116

  def initialize(seats = DEFAULT_SEATS)
    super(TRAIN_TYPES[:passenger])
    @seats = seats
    @used_seats = 0
  end

  def take_seat(count = 1)
    return if @seats == 0
    @used_seats += count
  end

  def free_seats
    @seats - @used_seats
  end
end