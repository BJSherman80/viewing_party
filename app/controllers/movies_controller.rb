class MoviesController < ApplicationController
  def show
    conn = Faraday.new(url: 'https://api.themoviedb.org') do |f|
      f.params['api_key'] = ENV['MOVIE_API_KEY']
    end
    movie_id = params[:id]
    movie_stats = conn.get("/3/movie/#{movie_id}")
    @movie_stats = JSON.parse(movie_stats.body, symbolize_names: true)
    movie_reviews = conn.get("/3/movie/#{movie_id}/reviews")
    @movie_reviews = JSON.parse(movie_reviews.body, symbolize_names: true)
    movie_cast = conn.get("/3/movie/#{movie_id}/credits")
    @movie_cast = JSON.parse(movie_cast.body, symbolize_names: true)
  end

  def index
    @movies = MovieFacade.fetch_top_40_movie_data
  end

  def search
    @search_results = SearchFacade.fetch_movie_data(params[:search])
  end
end
