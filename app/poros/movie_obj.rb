class MovieObj
  attr_reader :title, :runtime, :api_key, :vote_average, :id

  def initialize(attr)
    @title = attr[:title]
    @runtime = attr[:runtime]
    @api_key = attr[:api_key]
    @vote_average = attr[:vote_average]
    @id = attr[:id]
  end
end
