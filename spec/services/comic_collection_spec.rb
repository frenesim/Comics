require 'rails_helper'

RSpec.describe ComicCollection do

  before :each do
    # stub the time to allow recording a cassette
    allow(Time).to receive(:now) {Time.new(2020, 12, 12, 2, 2, 2, "+02:00") }
  end

  context "instance methods" do

    before :each do
        @comic = ComicCollection.new
        @comic.limit = 98
        @comic.offset = 150
    end

    describe 'all' do
      it 'returns all fetched comics' do
        VCR.use_cassette 'marvel/comics_with_params' do
          expect(@comic.all.count).to eq 98
        end
      end
    end

    describe 'ids' do
      it 'returns collection ids' do
        VCR.use_cassette 'marvel/comics_with_params' do
          expect(@comic.ids).to include 76360, 84381, 90548, 82248, 77943, 88751, 84260, 80615, 88753, 78713, 80491, 77133
        end
      end
    end

    describe 'comics' do
      it 'returns an array of comic instance ready to be fetch from source' do
        VCR.use_cassette 'marvel/comics_with_params' do
          expect(@comic.comics.count).to eq 98
          expect(@comic.comics.sample).to be_a Comic
        end
      end
    end
  end

end