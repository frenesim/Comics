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

    describe 'fetch' do
      it 'returns fetch fetched comics' do
        VCR.use_cassette 'marvel/comic_collection' do
          expect(@comic.fetch.count).to eq 98
        end
      end
    end

    describe 'ids' do
      it 'returns collection ids' do
        VCR.use_cassette 'marvel/comic_collection' do
          expect(@comic.ids).to include 85938, 82506, 93424, 82246, 77110, 78725, 80120, 77996, 85507, 81078, 77347, 79947, 85304, 78360
        end
      end
    end

    describe 'comics' do
      it 'returns an array of comic instance ready to be fetch from source' do
        VCR.use_cassette 'marvel/comic_collection_with_commics' do
          expect(@comic.comics.count).to eq 98
          expect(@comic.comics.sample).to be_a Comic
        end
      end
    end

    describe 'total' do
      it 'returns the total number of comics in the request' do
        expect(@comic.total).to eq 27489
      end
    end
  end

end