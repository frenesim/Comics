class ComicCollection < MarvelApi

  attr_accessor :limit, :offset, :characters

  def initialize
    super("comics")
    @limit = 20
    @offset = 0
  end

  def fetch
    query_string = "format=comic&formatType=comic&noVariants=true&orderBy=-onsaleDate&hasDigitalIssue=true&"
    query_string << "limit=#{@limit}&"
    query_string << "offset=#{@offset}&"
    query_string << "characters=#{@characters}&" if @characters
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