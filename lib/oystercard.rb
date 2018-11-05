# A class of cards to be used on a transport system

class Oystercard

  attr_reader :balance, :entry_station

  DEFAULT_BALANCE = 0
  CARD_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @entry_station = nil
  end

  def top_up(amount)
    fail "Cannot exceed maximum of £#{CARD_LIMIT}" if exceeds_limit?(amount)
    @balance += amount
  end

  def in_journey?
    @entry_station
  end

  def touch_in(station)
    fail "Balance below £#{MINIMUM_FARE}, top-up required" if below_minimum?
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
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
