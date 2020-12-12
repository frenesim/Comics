class ComicCollection < MarvelApi

  attr_accessor :limit, :offset

  def initialize
    super("comics")
  end

  def all
    query_string = "format=comic&formatType=comic&noVariants=true&orderBy=-onsaleDate&"
    query_string << "limit=#{limit}&" if limit
    query_string << "offset=#{offset}&" if offset
    self.query = query_string.chop!
    request unless @all.present?
    @all ||= results
  end

  def ids
    all.map{|a| a["id"]}
  end

  def comics
    ids.map do |id|
      Comic.new(id)
    end
  end
end