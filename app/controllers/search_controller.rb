class SearchController < ApplicationController
  def index
    @search_results = SearchFacade.fetch_movie_data(params[:search])
  end
end
