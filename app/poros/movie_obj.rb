class MovieObj
  attr_reader :title, :runtime, :vote_average, :api_id, :genres, :summary, :release_date

  def initialize(attr)
    @title = attr[:title]
    @runtime = attr[:runtime]
    @vote_average = attr[:vote_average]
    @api_id = attr[:id]
    @genres = attr[:genres]
    @summary = attr[:overview]
    @release_date = attr[:release_date]
  end
end
