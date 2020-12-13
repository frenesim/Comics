require 'rails_helper'

RSpec.describe Character do


  before :each do
    # stub the time to allow recording a cassette
    allow(Time).to receive(:now) {Time.new(2020, 12, 12, 2, 2, 2, "+02:00") }
  end

  # before :each do
  #     @comic = Character.new("deadpool")
  # end
  let :deadpool do
    Character.new("deadpool")
  end

  let :frenesim do
    Character.new("frenesim")
  end

  describe 'character' do
    it 'returns a character by name' do
      VCR.use_cassette 'character/deadpool' do
        expect(deadpool.character.name).to eq "Deadpool"
        expect(deadpool.character.id).to eq 1009268
      end
    end

    it 'returns nil if the name does not exist' do
      VCR.use_cassette 'character/frenesim' do
        expect(frenesim.character.id).to be_nil
      end
    end
  end

  describe 'id' do
    it 'returns an id' do
      VCR.use_cassette 'character/deadpool' do
        expect(deadpool.id).to eq 1009268
      end
    end
  end

  describe 'comics' do
    it 'returns a list of comics where the character participate' do
      VCR.use_cassette 'character/deadpool' do
        expect(deadpool.comics.sample).to be_a Comic
      end
    end
    it 'returns a list of comics where the character participate' do
      VCR.use_cassette 'character/frenesim' do
        expect(frenesim.comics).to be_nil
      end
    end
  end

end