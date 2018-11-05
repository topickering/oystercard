class Oystercard

  attr_reader :balance

  DEFAULT_BALANCE = 0
  CARD_LIMIT = 90

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(amount)
    fail "Cannot exceed maximum of £#{CARD_LIMIT}" if exceeds_limit?(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  private

  def exceeds_limit?(amount)
    (@balance + amount) > CARD_LIMIT
  end

end
