require 'oystercard'

describe Oystercard do

  let(:minimum) { Oystercard::MINIMUM_FARE }

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

  describe '#touch_in' do
    it 'will not allow touching_in without a minimum balance' do
      expect { subject.touch_in }.to raise_error "Balance below £#{minimum}, top-up required"
    end
    it 'changes in_use status to true when using touch_in' do
      subject.top_up(minimum)
      subject.touch_in
      expect(subject).to be_in_journey
    end
  end

  describe '#touch_out' do
    it 'changes in_use status to false when using touch_out' do
      subject.top_up(minimum)
      subject.touch_in
      subject.touch_out
      expect(subject).to_not be_in_journey
    end
    it 'charges a fare for a journey' do
      subject.top_up(minimum)
      subject.touch_in
      expect { subject.touch_out }.to change{ subject.balance}.by (-minimum)
    end
  end

end
