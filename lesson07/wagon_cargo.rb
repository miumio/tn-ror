require_relative "wagon"
require_relative 'train_types'

class CargoWagon < Wagon
  attr_reader :volume , :used_volume
  DEFAULT_VOLUME = 100

  def initialize(volume = DEFAULT_VOLUME)
    super(TRAIN_TYPES[:cargo])
    @volume = volume
    @used_volume = 0
  end

  def take_volume(volume)
    @used_volume += volume
  end

  def free_volume()
    @volume - @used_volume
  end
end