class ComicCollection < MarvelApi

  attr_accessor :limit, :offset

  def initialize
    super("comics")
    @limit = 20
    @offset = 0
  end

  def fetch
    query_string = "format=comic&formatType=comic&noVariants=true&orderBy=-onsaleDate&"
    query_string << "limit=#{@limit}&"
    query_string << "offset=#{@offset}&"
    self.query = query_string.chop!
    request unless @fetch.present?
    @fetch ||= results
  end

  def ids
    fetch.map{|a| a["id"]}
  end

  def comics
    ids.map do |id|
      Comic.new(id)
    end
  end

  def total
    fetch
    data["total"]
  end
end