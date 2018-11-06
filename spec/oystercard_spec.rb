require 'oystercard'

describe Oystercard do

  let(:minimum) { Oystercard::MINIMUM_FARE }
  let(:station) {'station'}

  it 'has a balance which defaults to zero' do
    expect(subject.balance).to eq 0
  end
  it 'has no journey history on initialization' do
    expect(subject.journeys.empty?).to be true
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
      expect { subject.touch_in(station) }.to raise_error "Balance below £#{minimum}, top-up required"
    end
    it 'changes in_use status to true when using touch_in' do
      subject.top_up(minimum)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end
    it 'records the entry station on the card' do
      subject.top_up(minimum)
      subject.touch_in(station)
      expect(subject.current_journey[:entry_station]).to eq station
    end
  end

  describe '#touch_out' do
    it 'records the exit station when touching out' do
      subject.top_up(minimum)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.journeys[0][:exit_station]).to eq station
    end
    it 'changes entry_station status to nil when using touch_out' do
      subject.top_up(minimum)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject).to_not be_in_journey
    end
    it 'charges a fare for a journey' do
      subject.top_up(minimum)
      subject.touch_in(station)
      expect { subject.touch_out(station) }.to change{ subject.balance}.by (-minimum)
    end
    it 'records a journey in the journey history' do
      subject.top_up(minimum)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.journeys.length).to eq 1
    end
  end

end
