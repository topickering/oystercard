require_relative 'station'

class Oystercard

  attr_reader :balance, :journeys, :current_journey

  DEFAULT_BALANCE = 0
  CARD_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @journeys = []
    @current_journey = {}
  end

  def top_up(amount)
    fail "Cannot exceed maximum of £#{CARD_LIMIT}" if exceeds_limit?(amount)
    @balance += amount
  end

  def in_journey?
    !@current_journey.empty?
  end

  def touch_in(station)
    fail "Balance below £#{MINIMUM_FARE}, top-up required" if below_minimum?
    @current_journey[:entry_station] = station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @current_journey[:exit_station] = station
    @journeys << @current_journey
    @current_journey = {}
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def exceeds_limit?(amount)
    (@balance + amount) > CARD_LIMIT
  end

  def below_minimum?
    @balance < MINIMUM_FARE
  end

end
