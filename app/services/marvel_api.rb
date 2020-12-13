class MarvelApi

  HOST = "gateway.marvel.com"
  PATH = "/v1/public/"
  PUBLIC_KEY = Rails.application.credentials.marvel_public_key
  PRIVATE_KEY = Rails.application.credentials.marvel_private_key
  REDIS_TTL = 60 * 24 * 24


  attr_reader :response, :body, :data, :results

  def initialize(endpoint = '')
    @endpoint = endpoint
    ts = Time.now.to_i.to_s
    hash_value = Digest::MD5.hexdigest ts + PRIVATE_KEY + PUBLIC_KEY
    @authentication_query_string = "ts=#{Time.now.to_i}&apikey=#{PUBLIC_KEY}&hash=#{hash_value}"
  end

  def request
    if cached?
      @data = JSON.parse(cache)
    else
      @response ||= Net::HTTP.get_response(uri)
      @body = JSON.parse(@response.body)
      @data = @body["data"]
      @results = @data["results"]
      redis.set(redis_key, @data.to_json, ex: REDIS_TTL)
    end
    @results = @data["results"]
  end

  def query=(query)
    @query = "&#{query}"
  end

  private
    def uri
      URI::HTTPS.build(host: HOST, path: PATH + @endpoint, query: @authentication_query_string + @query.to_s)
    end

    def redis
      begin
        Redis.current
      rescue
        warn "redis FAILED!! check if redis server is up!"
      end
    end

    def cached?
      redis.get(redis_key)
    end
    alias_method :cache, :cached?

    def redis_key
      # Exclude marvel params and use the remaining to form the redis key
      decode_query = URI.decode_www_form(uri.query)
      @endpoint + decode_query.reject{|param| ["ts", "hash", "apikey"].include? param[0]}.join
    end
end