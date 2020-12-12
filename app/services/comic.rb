class Comic < MarvelApi

  attr_reader :id

  def initialize(id)
    @id = id
    super("comics/#{id}")
    request
    @results = OpenStruct.new results[0]
  end

  def cover_url
    thumbnail = @results.thumbnail
    unless thumbnail["path"] =~ /image_not_available/i
      [thumbnail["path"], thumbnail["extension"]].join('.')
    end
  end

end