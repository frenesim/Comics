class Character < MarvelApi

  def initialize(name)
    super("characters")
    self.query = "name=#{name}"
    request
  end

  def character
    @character ||= OpenStruct.new results[0]
  end

  def id
    character.id
  end

  def comics
    character.comics["items"].map do |cc|
      cc["resourceURI"]
    end.map do |uri|
      uri[/\d*$/]
    end.map do |id|
      Comic.new id
    end if character.comics.present?
  end

end