# A class of cards to be used on a transport system

class Oystercard

  attr_reader :balance, :in_journey

  DEFAULT_BALANCE = 0
  CARD_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @in_use = false
  end

  def top_up(amount)
    fail "Cannot exceed maximum of £#{CARD_LIMIT}" if exceeds_limit?(amount)
    @balance += amount
  end

  def in_journey?
    @in_use == true
  end

  def touch_in
    fail "Balance below £#{MINIMUM_FARE}, top-up required" if below_minimum?
    @in_use = true
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @in_use = false
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
