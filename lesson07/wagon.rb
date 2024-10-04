require './modules/manufacturer'

class Wagon
  include Manufacturer

  attr_reader :type, :number
  
  def initialize(type)
    @type = type
    @number = rand(1...1000).to_s
  end
end