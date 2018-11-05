require 'oystercard'

describe Oystercard do

  it 'has a balance which defaults to zero' do
      expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    it 'allows a user to increase the balance on their oystercard' do
      expect { subject.top_up(10) }.to change{ subject.balance }.by 10
    end
  end


end
