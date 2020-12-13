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

  def favorite(current_session)
    Favorite.find_by(comic_id: id, user_session: current_session)
  end

end