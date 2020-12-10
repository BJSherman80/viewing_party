class CastObj
  attr_reader :name, :character

  def initialize(attr)
    @name = attr[:name]
    @character = attr[:character]
  end
end
