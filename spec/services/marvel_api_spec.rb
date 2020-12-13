require 'rails_helper'

RSpec.describe MarvelApi do

  let :marvel_api do
    MarvelApi.new("comics")
  end

  before :each do
    # stub the time to allow recording a cassette
    allow(Time).to receive(:now) {Time.new(2020, 12, 12, 2, 2, 2, "+02:00") }
  end

  describe 'initialize' do
    it 'instantiate' do
      expect(marvel_api).to be_a MarvelApi
    end
  end

  context 'wihtout cache' do
    before :each do
      marvel_api.send(:redis).flushdb
    end

    describe 'request' do
      it 'gets a response' do
        VCR.use_cassette 'marvel/comics' do
          marvel_api.request
          expect(marvel_api.response).to be_a Net::HTTPOK
        end
      end
    end

    context 'after the request' do
      before :each do
        VCR.use_cassette 'marvel/comics' do
          marvel_api.request
        end
      end

      describe 'body' do
        it 'has a body with meta information along with the data' do
          expect(marvel_api.body).to include "code", "status", "copyright", "attributionText", "attributionHTML", "etag", "data"
        end
      end

      describe 'data' do
        it 'has the data' do
          expect(marvel_api.data).to include "offset", "limit", "total", "count", "results"
        end
      end

      describe 'results' do
        it 'has the results' do
          expect(marvel_api.results[0].keys).to include "id", "digitalId", "title", "creators", "characters"
        end
      end
    end
  end

  context 'with cache' do
    context 'after the request' do
      before :each do
        VCR.use_cassette 'marvel/comics' do
          marvel_api.request
        end
      end

      describe 'data' do
        it 'has the data' do
          expect(marvel_api.data).to include "offset", "limit", "total", "count", "results"
        end
      end

      describe 'results' do
        it 'has the results' do
          expect(marvel_api.results[0].keys).to include "id", "digitalId", "title", "creators", "characters"
        end
      end
    end
  end

  describe 'private methods' do

    it 'has a uri' do
      expect(marvel_api.send(:uri)).to be_a URI::HTTPS
      expect(marvel_api.send(:uri).request_uri).to eq "/v1/public/comics?ts=1607731322&apikey=07e3e205bebd46de31d15ee9a76d85c2&hash=92c26f3f2c82cd12ce27f137e0e7ee31"
    end

    it 'has a redis key excluding marvel params' do
      marvel_api.query= "test=redis"
      expect(marvel_api.send(:redis_key)).to eq "comicstestredis"
    end

    it 'has a checks if there is cached information within redis' do
      marvel_api.send(:redis).flushdb
      expect(marvel_api.send(:cached?)).to be_nil
      marvel_api.request
      expect(marvel_api.send(:cache)).to be_truthy
      expect(marvel_api.send(:cached?)).to be_truthy
      expect(marvel_api.results[0].keys).to include "id", "digitalId", "title", "issueNumber", "variantDescription"
    end
  end

end