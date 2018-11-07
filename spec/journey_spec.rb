require 'journey'

describe Journey do

  let(:station1) { double :station }
  let(:station2) { double :station }

  describe '#start' do
    it 'records an entry station' do
      subject.start(station1)
      expect(subject.current_journey[:entry_station]).to eq station1
    end
  end

  describe '#finish' do
    it 'records an exit station' do
      subject.start(station1)
      subject.finish(station2)
      expect(subject.current_journey[:exit_station]).to eq station2
    end
  end

  describe '#complete?' do
    it 'confirms whether a journey is complete' do
      subject.start(station1)
      expect(subject).not_to be_complete
    end
  end

  describe '#fare' do
    it 'calculates a fare' do
      subject.start(station1)
      subject.finish(station2)
      expect(subject.fare).to eq Journey::MINIMUM_FARE
    end
    it 'has a penalty fare' do
      subject.finish(station2)
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end
  end

end
