require 'oystercard'

describe Oystercard do

  it 'has a balance which defaults to zero' do
      expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    it 'allows a user to increase the balance on their oystercard' do
      expect { subject.top_up(10) }.to change{ subject.balance }.by 10
    end
    it 'will not allow balance to exceed a maximum' do
      card_limit = Oystercard::CARD_LIMIT
      subject.top_up(card_limit)
      expect { subject.top_up(1) }.to raise_error "Cannot exceed maximum of £#{card_limit}"
    end
  end

  describe 'deduct' do
    it 'allows deductions from the balance' do
      subject.top_up(10)
      expect { subject.deduct(1) }.to change{ subject.balance }.by -1
    end
  end

  describe '#touch_in' do
    it 'changes in_use status to true when using touch_in' do
      subject.touch_in
      expect(subject).to be_in_journey
    end
  end

  describe '#touch_out' do
    it 'changes in_use status to false when using touch_out' do
      subject.touch_in
      subject.touch_out
      expect(subject).to_not be_in_journey
    end
  end

end
