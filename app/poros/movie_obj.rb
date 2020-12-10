class MovieObj
  attr_reader :title, :runtime, :vote_average, :api_id, :genres, :summary

  def initialize(attr)
    @title = attr[:title]
    @runtime = attr[:runtime]
    @vote_average = attr[:vote_average]
    @api_id = attr[:id]
    @genres = attr[:genres]
    @summary = attr[:overview]
  end
end
