require_relative "wagon"
require_relative 'train_types'

class CargoWagon < Wagon
  attr_reader :volume , :available_volume
  DEFAULT_VOLUME = 100

  def initialize(volume = DEFAULT_VOLUME)
    super(TRAIN_TYPES[:cargo])
    @volume = volume
    @available_volume = volume
  end

  def set_volume(volume)
    @available_volume = volume
  end

  def used_volume
    @volume - @available_volume
  end

  def free_volume()
    @available_volume
  end
end