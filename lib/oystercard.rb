require_relative 'station'
require_relative 'journey'

class Oystercard

  attr_reader :balance, :journeys, :current_journey

  DEFAULT_BALANCE = 0
  CARD_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @journeys = []
    @this_journey = Journey.new
  end

  def top_up(amount)
    fail "Cannot exceed maximum of £#{CARD_LIMIT}" if exceeds_limit?(amount)
    @balance += amount
  end

  def in_journey?
    !@this_journey.current_journey.empty?
  end

  def touch_in(station)
    fail "Balance below £#{MINIMUM_FARE}, top-up required" if below_minimum?
    @this_journey.start(station)
  end

  def touch_out(station)
    @this_journey.finish(station)
    deduct(@this_journey.fare)
    @journeys << @this_journey
    @this_journey = Journey.new
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
