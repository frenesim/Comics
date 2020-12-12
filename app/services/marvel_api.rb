class MarvelApi

  HOST = "gateway.marvel.com"
  PUBLIC_KEY = Rails.application.credentials.marvel_public_key
  PRIVATE_KEY = Rails.application.credentials.marvel_private_key

  attr_reader :response, :body, :data, :results

  def initialize(endpoint = '')
    @endpoint = "/v1/public/" + endpoint
    ts = Time.now.to_i.to_s
    hash_value = Digest::MD5.hexdigest ts + PRIVATE_KEY + PUBLIC_KEY
    @authentication_query_string = "ts=#{Time.now.to_i}&apikey=#{PUBLIC_KEY}&hash=#{hash_value}"
  end

  def request
    @response ||= Net::HTTP.get_response(uri)
    @body = JSON.parse(@response.body)
    @data = @body["data"]
    @results = @data["results"]
  end

  def query=(query)
    @query = "&#{query}"
  end

  private
    def uri
      URI::HTTPS.build(host: HOST, path: @endpoint, query: @authentication_query_string + @query.to_s)
    end


end