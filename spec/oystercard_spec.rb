require 'oystercard'

describe Oystercard do
  it 'has a balance which defaults to zero' do
      expect(subject.balance).to eq 0
  end

end
