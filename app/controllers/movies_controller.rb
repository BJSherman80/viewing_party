class MoviesController < ApplicationController
  def show
    @movie = MovieFacade.movie_details(params[:id])
    @reviews = MovieFacade.fetch_movie_reviews(params[:id])
    @cast = MovieFacade.fetch_movie_cast(params[:id])
  end

  def index
    # @movies = MovieFacade.fetch_top_40_movies
    # @search_results = MovieFacade.fetch_movie_search_results(params[:search]) if params[:search]
    @movies = MovieFacade.top_rated_or_search(params[:search])
  end
  #
  # def search
  #   require "pry"; binding.pry
  # end
end
