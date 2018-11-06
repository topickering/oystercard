require 'station'

describe Station do

  let(:test_station) { described_class.new('Angel', 1) }

  it 'has a name' do
    expect(test_station.name).to eq 'Angel'
  end
  it 'is in a zone' do
    expect(test_station.zone).to eq 1
  end

end
