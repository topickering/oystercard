class Journey

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  attr_accessor :current_journey

  def initialize
    @current_journey = {}
  end

  def start(station)
    @current_journey[:entry_station] = station
  end

  def finish(station)
    @current_journey[:exit_station] = station
  end

  def fare
    complete? ? MINIMUM_FARE : PENALTY_FARE
  end

  def complete?
    @current_journey.has_key?(:entry_station) && @current_journey.has_key?(:exit_station)
  end

end
