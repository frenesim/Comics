require 'rails_helper'

RSpec.describe Comic do

  before :each do
    # stub the time to allow recording a cassette
    allow(Time).to receive(:now) {Time.new(2020, 12, 12, 2, 2, 2, "+02:00") }
  end

  context "instance methods" do

    let :comic do
      Comic.new(23)
    end

    describe 'cover_url' do
      it 'returns the cover page url' do
        VCR.use_cassette 'marvel/comic/23' do
          expect(comic.cover_url).to eq "http://i.annihil.us/u/prod/marvel/i/mg/9/60/5c8a80552e8ba.jpg"
        end
      end

      it 'returns nil if no cover is available' do
        VCR.use_cassette 'marvel/comic/22253' do
          expect(Comic.new(22253).cover_url).to be_nil
        end
      end
    end

  end
end